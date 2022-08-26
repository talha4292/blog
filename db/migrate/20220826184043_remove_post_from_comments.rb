# frozen_string_literal: true

# RemovePostFromComments
class RemovePostFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_reference :comments, :post, foreign_key: true
  end
end
