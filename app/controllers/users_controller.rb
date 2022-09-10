# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
  end
end
