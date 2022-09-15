# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  scope :descending, -> { order(updated_at: :desc) }

  validates :user_id, uniqueness: { scope: %i[likeable_id likeable_type] }
end
