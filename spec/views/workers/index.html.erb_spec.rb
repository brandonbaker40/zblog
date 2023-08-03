require 'rails_helper'

RSpec.describe "workers/index", type: :view do
  before(:each) do
    assign(:workers, [
      Worker.create!(
        worker_type: 2,
        payroll_workerId: "Payroll Worker",
        work_email: "Work Email",
        personal_email: "Personal Email",
        contact_phone: "Contact Phone",
        profile: nil
      ),
      Worker.create!(
        worker_type: 2,
        payroll_workerId: "Payroll Worker",
        work_email: "Work Email",
        personal_email: "Personal Email",
        contact_phone: "Contact Phone",
        profile: nil
      )
    ])
  end

  it "renders a list of workers" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Payroll Worker".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Work Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Personal Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Contact Phone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
