# frozen_string_literal: true

class Suggestion < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comments, as: :commentable, dependent: :destroy

  scope :descending, -> { order(updated_at: :desc) }

  validates :user_id, uniqueness: { scope: :post_id }
  validates :text, presence: true
end
