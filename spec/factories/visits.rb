FactoryBot.define do
  factory :visit do
    date_of_service { Faker::Date.between(from: '2021-01-01', to: '2022-12-31') }
    webptvisitid { "293475634" }
    patient
  end
end
