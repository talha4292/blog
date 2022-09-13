# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  belongs_to :reportable, polymorphic: true

  scope :descending, -> { order(updated_at: :desc) }

  validates :user_id, uniqueness: { scope: %i[reportable_id reportable_type] }
  validates :text, presence: true
end
