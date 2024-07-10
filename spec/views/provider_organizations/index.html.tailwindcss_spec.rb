require 'rails_helper'

RSpec.describe "provider_organizations/index", type: :view do
  before(:each) do
    assign(:provider_organizations, [
      ProviderOrganization.create!(
        name: "Name",
        kind: 2
      ),
      ProviderOrganization.create!(
        name: "Name",
        kind: 2
      )
    ])
  end

  it "renders a list of provider_organizations" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
