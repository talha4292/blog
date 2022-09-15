# frozen_string_literal: true

# Dashboard
class DashboardController < ApplicationController
  before_action :set_dashboard_policy, only: %i[index]

  def index
    @posts = Post.approved.descending
    @comments = Comment.where(parent_id: nil).descending.limit(5)
    @likes = Like.descending.limit(5)
  end

  private

  def set_dashboard_policy
    authorize Post
  end
end
