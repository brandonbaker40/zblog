class PaychexApiService
    require 'net/http'
    require 'httparty'

    def initialize(r)
        @r = r
    end

    def call
        token_auth_request_uri = URI('https://api.paychex.com/auth/oauth/v2/token')
        token_auth_response = Net::HTTP.post_form(token_auth_request_uri, 'grant_type' => 'client_credentials', 'client_id' => ENV["PAYCHEX_CLIENT_ID"], 'client_secret' => ENV["PAYCHEX_CLIENT_SECRET"])
        token = JSON.parse(token_auth_response.body)["access_token"]
        companies = HTTParty.get("https://api.paychex.com/companies/004UWBZQL8M4VJADHR6C/workers", headers: {"Authorization" => "Bearer #{token}"})


        worker_ids = []
        workers = JSON.parse(companies)["content"].each {|w| worker_ids.push(w["workerId"])}

        # Query the database for a list of worker ID's that are already in the database and subtract those before looping over them to determine which payroll profile should be assigned
        worker_ids_already_in_db_example = ["004UWBZQL8X86QX5SY0G","004UWBZQL8M8ZOB36627", "004UWBZQL8M92ZXX6F1D", "004UWBZQL8M93GCF6F41", "004UWBZQL8M936ZZ6E12"]
        # puts worker_ids[6]

        worker_ids = worker_ids - worker_ids_already_in_db_example

        worker_ids.each do |wid|
          comm = JSON.parse(HTTParty.get("https://api.paychex.com/workers/#{wid}/communications", headers: {"Authorization" => "Bearer #{token}"}))["content"]
          #puts "***"
          #puts comm
          #puts "***"
          comm.each do |x|
            if (x["type"] == "EMAIL") && (x["usageType"] == "BUSINESS")
               puts x["uri"]
               if x["uri"] == ""
                 # create a Worker object that pulls only fields from Paychex
                 # profile has one Worker
                 # Worker belongs to profile

                 # create a WorkerProfile object linking Worker and Profile

               end
            end
          end
          # break
        end


    end
end
