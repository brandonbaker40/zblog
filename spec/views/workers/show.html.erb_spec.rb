require 'rails_helper'

RSpec.describe "workers/show", type: :view do
  before(:each) do
    assign(:worker, Worker.create!(
      worker_type: 2,
      payroll_workerId: "Payroll Worker",
      work_email: "Work Email",
      personal_email: "Personal Email",
      contact_phone: "Contact Phone",
      profile: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Payroll Worker/)
    expect(rendered).to match(/Work Email/)
    expect(rendered).to match(/Personal Email/)
    expect(rendered).to match(/Contact Phone/)
    expect(rendered).to match(//)
  end
end
