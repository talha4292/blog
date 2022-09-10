# frozen_string_literal: true

# RemoveCommentFromReports
class RemoveCommentFromReports < ActiveRecord::Migration[5.2]
  def change
    remove_reference :reports, :comment, foreign_key: true
  end
end
