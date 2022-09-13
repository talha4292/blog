# frozen_string_literal: true

# User
class User < ApplicationRecord
  include ImageUploader::Attachment(:image)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reports, dependent: :destroy

  enum role: { user: 0, moderator: 1, admin: 2 }

  validates :first_name, :last_name, :birthday, presence: true
  validates :first_name, :last_name, length: { maximum: 15 }
  validates :username, length: { in: 6..20 }
  validates :about, length: { maximum: 50 }
  validate :validate_age

  private

  def validate_age
    errors.add(:birthday, 'You must be over 18 years old.') if birthday.present? && birthday > 18.years.ago.to_date
  end
end
