# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  include Pundit
  before_action :config_permitted_params, if: :devise_controller?

  protected

  def config_permitted_params
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :username, :birthday, :email, :password, :password_confirmation, :remember_me)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |u|
      u.permit(:email, :password, :remember_me)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :username, :birthday, :about, :email, :password, :password_confirmation,
               :current_password, :remember_me, :image)
    end
  end
end
