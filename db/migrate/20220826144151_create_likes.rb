# frozen_string_literal: true

# CreateLikes
class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
