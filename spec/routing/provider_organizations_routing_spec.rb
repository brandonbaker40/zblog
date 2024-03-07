require "rails_helper"

RSpec.describe ProviderOrganizationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/provider_organizations").to route_to("provider_organizations#index")
    end

    it "routes to #new" do
      expect(get: "/provider_organizations/new").to route_to("provider_organizations#new")
    end

    it "routes to #show" do
      expect(get: "/provider_organizations/1").to route_to("provider_organizations#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/provider_organizations/1/edit").to route_to("provider_organizations#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/provider_organizations").to route_to("provider_organizations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/provider_organizations/1").to route_to("provider_organizations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/provider_organizations/1").to route_to("provider_organizations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/provider_organizations/1").to route_to("provider_organizations#destroy", id: "1")
    end
  end
end
