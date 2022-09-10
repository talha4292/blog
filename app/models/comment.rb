# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, as: :commentable, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
end
