class PaychexApiService
  require 'net/http'
  require 'httparty'

  class Authenticate
    def initialize
      # Authenticate on the Paychex API endpoint and request an auth token
      token_auth_request_uri = URI('https://api.paychex.com/auth/oauth/v2/token')
      token_auth_response = Net::HTTP.post_form(token_auth_request_uri, 'grant_type' => 'client_credentials', 'client_id' => ENV["PAYCHEX_CLIENT_ID"], 'client_secret' => ENV["PAYCHEX_CLIENT_SECRET"])
      @token = JSON.parse(token_auth_response.body)["access_token"]
    end

    def call
      return @token
    end
  end

  class BuildWorkerProfile
    def initialize(profile, token)
      @profile = profile
      @token = token
    end

    def call
        # Query the Paychex API for an array of (employee and contractor) objects,
        # then parse the string response to JSON and initialize an array of all workerID's in the company
        all_workers_in_paychex = HTTParty.get("https://api.paychex.com/companies/#{ENV["PAYCHEX_COMPANY_ID"]}/workers", headers: {"Authorization" => "Bearer #{@token}"})
        all_worker_ids_in_paychex = JSON.parse(all_workers_in_paychex)["content"].map {|x| x.values[0]}

        # Subtract the workerID's that are already assigned to a Profile in the database
        # from all of the workerID's that exist in the Paychex account
        # which produces an array of available workerID's.
        worker_ids_in_db = Worker.pluck(:payroll_workerId) # example output: ["004UWBZQL8M92W4D669P","004UWBZQL8M92T8Y69A5","004UWBZQL8M92TXU666R","004UWBZQL8M92W4D66A1","004UWBZQL8M92TXU6673","004UWBZQL8M92T8Y69AJ","004UWBZQL8M92TXU667D"]
        available_worker_ids = all_worker_ids_in_paychex - worker_ids_in_db

        # Iterate over the array of available workerID's
        # and query the Paychex API for contact information that
        # matches the email address of the profile
        available_worker_ids.each do |payroll_workerId|
          worker_communication_objects_string = HTTParty.get("https://api.paychex.com/workers/#{payroll_workerId}/communications", headers: {"Authorization" => "Bearer #{@token}"})
          business_email_object = JSON.parse(worker_communication_objects_string)["content"].select{ |x| (x["type"] == 'EMAIL') && (x["usageType"] == "BUSINESS")}[0]

          next if business_email_object.nil? # the Work Email field must be present in the Paychex Profile
          next if business_email_object["uri"] != @profile.email # the Work Email field in Paychex must match the email on the profile object

          # If and when email from Paychex API query matches the profile email,
          # query the API on that worker in Paychex and sync the contents to a Worker in the database
          # by creating a new worker
          if business_email_object["uri"] == @profile.email
            matched_worker_object_string = HTTParty.get("https://api.paychex.com/workers/#{payroll_workerId}", headers: {"Authorization" => "Bearer #{@token}"})
            matched_worker = JSON.parse(matched_worker_object_string)["content"]

            # Paychex Home Phone = (x["type"] == 'PHONE') && (x["usageType"] == "PERSONAL")
            # Paychex Work Phone = (x["type"] == 'PHONE') && (x["usageType"] == "BUSINESS")
            # ACTIVE: Paychex Mobile Phone = (x["type"] == 'MOBILE_PHONE') && (x["usageType"] == "BUSINESS")
            contact_phone_object = JSON.parse(worker_communication_objects_string)["content"].select{ |x| (x["type"] == 'MOBILE_PHONE') && (x["usageType"] == "BUSINESS")}[0]
            contact_phone_object.nil? ? contact_phone = nil : contact_phone = contact_phone_object["dialArea"] + contact_phone_object["dialNumber"]

            personal_email_object = JSON.parse(worker_communication_objects_string)["content"].select{ |x| (x["type"] == 'EMAIL') && (x["usageType"] == "PERSONAL")}[0]
            personal_email_object.nil? ? personal_email = nil : personal_email = personal_email_object["uri"]

            # IMPORTANT
            # If birthDate is nil
            # First name, last name, and worker_type are the only required fields to create a worker in Paychex,
            # so nil values should be checked for all other fields, except

            case matched_worker[0]["workerType"]
            when 'EMPLOYEE'
              worker_type = 0
            when 'CONTRACTOR'
              worker_type = 1
            else
              worker_type = 2
            end

            Worker.create(
              worker_type: worker_type,
              payroll_workerId: payroll_workerId,
              work_email: business_email_object["uri"],
              personal_email: personal_email,
              contact_phone: contact_phone,
              date_of_birth: matched_worker[0]["birthDate"],
              profile_id: @profile.id
            )

            address_object = JSON.parse(worker_communication_objects_string)["content"].select{ |x| (x["type"] == 'STREET_ADDRESS')}[0]
            if !address_object.nil?
              Address.create(
                streetLineOne: address_object["streetLineOne"],
                streetLineTwo: address_object["streetLineTwo"],
                city: address_object["city"],
                state: address_object["countrySubdivisionCode"],
                zip_code: address_object["postalCode"],
                addressable_type: "Profile",
                addressable_id: @profile.id
              )
            end
          end

          break # so that iteration stops once we've found a match

        end
    end
    handle_asynchronously :call
    
  end

end
