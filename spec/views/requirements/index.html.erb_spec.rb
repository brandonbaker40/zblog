require 'rails_helper'

RSpec.describe "requirements/index", type: :view do
  before(:each) do
    assign(:requirements, [
      Requirement.create!(
        name: "Name"
      ),
      Requirement.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of requirements" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
  end
end
