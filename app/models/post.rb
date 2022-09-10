# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  # has_rich_text :content

  enum status: { unapproved: 0, approved: 1 }
  scope :descending, -> { order(updated_at: :desc) }
end
