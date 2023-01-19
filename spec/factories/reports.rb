# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    text { Faker::Lorem.paragraph(sentence_count: 1) }
  end
end
