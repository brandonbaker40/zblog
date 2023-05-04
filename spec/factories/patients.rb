FactoryBot.define do
  factory :patient do
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    sex { rand(1..2) == 1 ? 0 : 1 } # 0 = male, 1 = female
    birthdate { Faker::Date.between(from: '1923-01-01', to: '1975-12-31') }
  end
end
