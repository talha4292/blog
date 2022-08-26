# frozen_string_literal: true

# RemovePostFromLikes
class RemovePostFromLikes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :likes, :post, foreign_key: true
  end
end
