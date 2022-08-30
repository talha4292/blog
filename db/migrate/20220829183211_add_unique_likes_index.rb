# frozen_string_literal: true

# AddUniqueLikesIndex
class AddUniqueLikesIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :likes, %i[user_id likeable_id likeable_type], unique: true
  end
end
