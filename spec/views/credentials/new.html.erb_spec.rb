require 'rails_helper'

RSpec.describe "credentials/new", type: :view do
  before(:each) do
    assign(:credential, Credential.new(
      requirement: nil,
      profile: nil
    ))
  end

  it "renders new credential form" do
    render

    assert_select "form[action=?][method=?]", credentials_path, "post" do

      assert_select "input[name=?]", "credential[requirement_id]"

      assert_select "input[name=?]", "credential[profile_id]"
    end
  end
end
