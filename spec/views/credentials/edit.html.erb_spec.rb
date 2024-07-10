require 'rails_helper'

RSpec.describe "credentials/edit", type: :view do
  let(:credential) {
    Credential.create!(
      requirement: nil,
      profile: nil
    )
  }

  before(:each) do
    assign(:credential, credential)
  end

  it "renders the edit credential form" do
    render

    assert_select "form[action=?][method=?]", credential_path(credential), "post" do

      assert_select "input[name=?]", "credential[requirement_id]"

      assert_select "input[name=?]", "credential[profile_id]"
    end
  end
end
