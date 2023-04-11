class WelcomeController < ApplicationController
  require 'net/http'
  require 'httparty'
  
  def index
    
    # This is not very serious method... just testing the API works... will move later. 
    r = "nothing"
    PaychexApiService.new(r).call
  end
end
