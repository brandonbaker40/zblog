# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


require 'faker'

5.times do |i|
  kind = nil 
  rand(1..2) == 1 ? kind = :home_health_agency : kind = :surgery_center
  ProviderOrganization.create(
    name: Faker::Company.name + " " + kind.to_s.humanize,
    kind: kind
  )
end

500.times do |i|
  sex = nil
  rand(1..2) == 1 ? sex = :male : sex = :female
  Patient.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    sex: sex,
    birthdate: Faker::Date.between(from: '1923-01-01', to: '1975-12-31')
  )
end
