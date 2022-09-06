# frozen_string_literal: true

class Suggestion < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comments, as: :commentable, dependent: :destroy

  has_rich_text :content

  scope :descending, -> { order(updated_at: :desc) }
end
