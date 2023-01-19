# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    traits_for_enum :status, %w[unapproved approved]
    title { Faker::Lorem.paragraph_by_chars(number: 50) }
    text { Faker::Lorem.paragraph(sentence_count: 2) }
    image_data do
      '{"id":"e814c119567baf77ea4af3755ea24c50.png","storage":"store","metadata":' \
        '{"filename":"video-bg.png","size":706733,"mime_type":"image/png","width":' \
        '1146,"height":560}}'
    end
  end
end
