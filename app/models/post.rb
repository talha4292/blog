# frozen_string_literal: true

class Post < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  enum status: { unapproved: 0, approved: 1 }
  scope :descending, -> { order(updated_at: :desc) }

  validates :title, presence: true, length: { maximum: 100 }
  validates :image, :text, presence: true
end
