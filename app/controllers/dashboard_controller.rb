# frozen_string_literal: true

# Dashboard
class DashboardController < ApplicationController
  before_action :set_dashboard_policy, only: %i[index]

  def index
    @posts = Post.approved.descending
  end

  private

  def set_dashboard_policy
    authorize Post
  end
end
