require 'rails_helper'

RSpec.describe "credentials/show", type: :view do
  before(:each) do
    assign(:credential, Credential.create!(
      requirement: nil,
      profile: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
