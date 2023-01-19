# frozen_string_literal: true

FactoryBot.define do
  factory :suggestion do
    text { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end
