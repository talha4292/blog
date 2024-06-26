# frozen_string_literal: true

# CreatePosts
class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
