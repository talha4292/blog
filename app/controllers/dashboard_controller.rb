# frozen_string_literal: true

# Dashboard
class DashboardController < ApplicationController
  def index
    @posts = Post.approved.descending
    authorize @posts
  end
end
