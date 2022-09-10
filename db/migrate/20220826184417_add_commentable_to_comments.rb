# frozen_string_literal: true

# AddCommentableToComments and AddParentToComments
class AddCommentableToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :commentable, polymorphic: true
    add_reference :comments, :parent, index: true
  end
end
