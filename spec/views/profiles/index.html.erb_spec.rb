require 'rails_helper'

RSpec.describe "profiles/index", type: :view do
  before(:each) do
    assign(:profiles, [
      Profile.create!(
        user: nil,
        first_name: "First Name",
        last_name: "Last Name",
        role: 2
      ),
      Profile.create!(
        user: nil,
        first_name: "First Name",
        last_name: "Last Name",
        role: 2
      )
    ])
  end

  it "renders a list of profiles" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("First Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Last Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
