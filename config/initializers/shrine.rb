# frozen_string_literal: true

require 'cloudinary'
require 'shrine/storage/cloudinary'

Cloudinary.config(
  cloud_name: Rails.application.credentials.dig(:cloudinary, :cloud_name),
  api_key: Rails.application.credentials.dig(:cloudinary, :api_key),
  api_secret: Rails.application.credentials.dig(:cloudinary, :api_secret)
)

Shrine.storages = {
  cache: Shrine::Storage::Cloudinary.new(prefix: 'blog/cache'), # for direct uploads
  store: Shrine::Storage::Cloudinary.new(prefix: 'blog')
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :validation_helpers
Shrine.plugin :validation
