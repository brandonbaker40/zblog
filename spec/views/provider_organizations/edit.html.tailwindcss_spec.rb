require 'rails_helper'

RSpec.describe "provider_organizations/edit", type: :view do
  let(:provider_organization) {
    ProviderOrganization.create!(
      name: "MyString",
      kind: 1
    )
  }

  before(:each) do
    assign(:provider_organization, provider_organization)
  end

  it "renders the edit provider_organization form" do
    render

    assert_select "form[action=?][method=?]", provider_organization_path(provider_organization), "post" do

      assert_select "input[name=?]", "provider_organization[name]"

      assert_select "input[name=?]", "provider_organization[kind]"
    end
  end
end
