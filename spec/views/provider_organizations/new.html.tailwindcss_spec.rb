require 'rails_helper'

RSpec.describe "provider_organizations/new", type: :view do
  before(:each) do
    assign(:provider_organization, ProviderOrganization.new(
      name: "MyString",
      kind: 1
    ))
  end

  it "renders new provider_organization form" do
    render

    assert_select "form[action=?][method=?]", provider_organizations_path, "post" do

      assert_select "input[name=?]", "provider_organization[name]"

      assert_select "input[name=?]", "provider_organization[kind]"
    end
  end
end
