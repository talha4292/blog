# frozen_string_literal: true

# RemoveCommentFromLikes
class RemoveCommentFromLikes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :likes, :comment, foreign_key: true
  end
end
