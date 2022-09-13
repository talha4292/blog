# frozen_string_literal: true

# AddConstraintsToTables
class AddConstraintsToTables < ActiveRecord::Migration[5.2]
  def self.up
    change_column :users, :first_name, :string, null: false
    change_column :users, :last_name, :string, null: false
    change_column :users, :username, :string, null: false, limit: 20, unique: true
    change_column :users, :birthday, :date, null: false
    change_column :users, :about, :text, null: true, limit: 50
    change_column :users, :image_data, :text, null: true
    change_column :posts, :title, :string, null: false, limit: 50
    change_column :posts, :text, :text, null: false
    change_column :reports, :text, :text, null: false
    change_column :suggestions, :text, :text, null: false
    change_column :comments, :text, :text, null: false

    add_index :reports, %i[user_id reportable_id reportable_type], unique: true
    add_index :suggestions, %i[user_id post_id], unique: true
  end

  def self.down
    remove_index :reports, %i[user_id reportable_id reportable_type], unique: true
    remove_index :suggestions, %i[user_id post_id], unique: true

    change_column :users, :first_name, :string
    change_column :users, :last_name, :string
    change_column :users, :username, :string
    change_column :users, :birthday, :date
    change_column :users, :about, :text
    change_column :users, :image_data, :text
    change_column :posts, :title, :string
    change_column :posts, :text, :text
    change_column :reports, :text, :text
    change_column :suggestions, :text, :text
    change_column :comments, :text, :text
  end
end
