FactoryBot.define do
  factory :profile do
    user { nil }
    first_name { "MyString" }
    last_name { "MyString" }
    role { 1 }
  end
end
