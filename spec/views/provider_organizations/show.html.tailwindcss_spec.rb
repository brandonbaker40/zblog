require 'rails_helper'

RSpec.describe "provider_organizations/show", type: :view do
  before(:each) do
    assign(:provider_organization, ProviderOrganization.create!(
      name: "Name",
      kind: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
