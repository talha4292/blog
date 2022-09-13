# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  def show
    authorize User
    @user = User.find(params[:id])
  end
end
