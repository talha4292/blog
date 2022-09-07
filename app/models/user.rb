# frozen_string_literal: true

# User
class User < ApplicationRecord
  include ImageUploader::Attachment(:image)

  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates_presence_of :first_name, :last_name, :birthday
  validates_uniqueness_of :username, case_sensitive: false
  validates :username, length: { in: 6..20 }
  validate :validate_age

  enum role: { user: 0, moderator: 1, admin: 2 }

  private

  def validate_age
    errors.add(:birthday, 'You must be over 18 years old.') if birthday.present? && birthday > 18.years.ago.to_date
  end
end
