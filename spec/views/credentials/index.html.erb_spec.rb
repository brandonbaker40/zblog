require 'rails_helper'

RSpec.describe "credentials/index", type: :view do
  before(:each) do
    assign(:credentials, [
      Credential.create!(
        requirement: nil,
        profile: nil
      ),
      Credential.create!(
        requirement: nil,
        profile: nil
      )
    ])
  end

  it "renders a list of credentials" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
