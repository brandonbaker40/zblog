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
        companies = HTTParty.get("https://api.paychex.com/companies", headers: {"Authorization" => "Bearer #{token}"})

        puts "***"
        puts companies
        puts "***"
    end
end