# frozen_string_literal: true

# AddImageDataToUsers
class AddImageDataToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_data, :text
  end
end
