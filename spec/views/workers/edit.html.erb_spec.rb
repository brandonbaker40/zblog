require 'rails_helper'

RSpec.describe "workers/edit", type: :view do
  let(:worker) {
    Worker.create!(
      worker_type: 1,
      payroll_workerId: "MyString",
      work_email: "MyString",
      personal_email: "MyString",
      contact_phone: "MyString",
      profile: nil
    )
  }

  before(:each) do
    assign(:worker, worker)
  end

  it "renders the edit worker form" do
    render

    assert_select "form[action=?][method=?]", worker_path(worker), "post" do

      assert_select "input[name=?]", "worker[worker_type]"

      assert_select "input[name=?]", "worker[payroll_workerId]"

      assert_select "input[name=?]", "worker[work_email]"

      assert_select "input[name=?]", "worker[personal_email]"

      assert_select "input[name=?]", "worker[contact_phone]"

      assert_select "input[name=?]", "worker[profile_id]"
    end
  end
end
