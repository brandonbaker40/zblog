FactoryBot.define do
  factory :worker do
    worker_type { 1 }
    payroll_workerId { "MyString" }
    work_email { "MyString" }
    personal_email { "MyString" }
    contact_phone { "MyString" }
    date_of_birth { "2023-07-28" }
    profile { nil }
  end
end
