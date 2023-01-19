# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    traits_for_enum :role, %w[user moderator admin]
    first_name { Faker::Name.name[1..15] }
    last_name { Faker::Name.name[1..15] }
    username { Faker::Internet.username(specifier: 6..20) }
    birthday { Faker::Date.between(from: 80.years.ago, to: 18.years.ago) }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    confirmed_at { Time.current }
  end
end
