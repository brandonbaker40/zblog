require 'rails_helper'

RSpec.describe "requirements/edit", type: :view do
  let(:requirement) {
    Requirement.create!(
      name: "MyString"
    )
  }

  before(:each) do
    assign(:requirement, requirement)
  end

  it "renders the edit requirement form" do
    render

    assert_select "form[action=?][method=?]", requirement_path(requirement), "post" do

      assert_select "input[name=?]", "requirement[name]"
    end
  end
end
