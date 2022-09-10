# frozen_string_literal: true

# RemovePostFromReports
class RemovePostFromReports < ActiveRecord::Migration[5.2]
  def change
    remove_reference :reports, :post, foreign_key: true
  end
end
