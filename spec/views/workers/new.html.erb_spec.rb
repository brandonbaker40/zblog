require 'rails_helper'

RSpec.describe "workers/new", type: :view do
  before(:each) do
    assign(:worker, Worker.new(
      worker_type: 1,
      payroll_workerId: "MyString",
      work_email: "MyString",
      personal_email: "MyString",
      contact_phone: "MyString",
      profile: nil
    ))
  end

  it "renders new worker form" do
    render

    assert_select "form[action=?][method=?]", workers_path, "post" do

      assert_select "input[name=?]", "worker[worker_type]"

      assert_select "input[name=?]", "worker[payroll_workerId]"

      assert_select "input[name=?]", "worker[work_email]"

      assert_select "input[name=?]", "worker[personal_email]"

      assert_select "input[name=?]", "worker[contact_phone]"

      assert_select "input[name=?]", "worker[profile_id]"
    end
  end
end
