FactoryBot.define do
  factory :address do
    streetLineOne { "MyString" }
    streetLineTwo { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip_code { "MyString" }
    addressable { nil }
  end
end
