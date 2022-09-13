# frozen_string_literal: true

require 'cloudinary'
require 'shrine/storage/cloudinary'

Cloudinary.config(
  cloud_name: 'du2ddzhhf',
  api_key: '799376471897378',
  api_secret: 'iRhLPkvbPHCyFA2H-BePCk6okJg'
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
