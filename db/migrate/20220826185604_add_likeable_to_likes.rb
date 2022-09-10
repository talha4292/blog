# frozen_string_literal: true

# AddLikeableToLikes
class AddLikeableToLikes < ActiveRecord::Migration[5.2]
  def change
    add_reference :likes, :likeable, polymorphic: true
  end
end
