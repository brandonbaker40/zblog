class MicrosoftGraphFetchUserProfileService
  require 'net/http'
  require 'httparty'

  def initialize(user)
      @upn = user.email
  end

  def call
    tenant = ENV["AZURE_TENANT_ID_ZBLOG"]
    token_auth_request_uri = URI("https://login.microsoftonline.com/#{tenant}/oauth2/v2.0/token")
    token_auth_response = Net::HTTP.post_form(token_auth_request_uri, 'grant_type' => 'client_credentials', 'client_id' => ENV["AZURE_CLIENT_ID_ZBLOG"], 'client_secret' => ENV["AZURE_CLIENT_SECRET_VALUE_ZBLOG"], 'scope' => "https://graph.microsoft.com/.default")
    token = JSON.parse(token_auth_response.body)["access_token"]

    aad_object = HTTParty.get("https://graph.microsoft.com/v1.0/users/#{@upn}", headers: {"Authorization" => "Bearer #{token}", "Host" => "graph.microsoft.com"})

    return aad_object
  end
end
