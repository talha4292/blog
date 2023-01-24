# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include ActionController::Serialization

  # before_action :authenticate_user!, unless: :devise_controller?
  
  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers
  before_action :config_permitted_params, if: :devise_controller?
  # after_action :verify_authorized, unless: :devise_controller?
  protect_from_forgery with: :exception

  
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def cors_preflight_check
    return if request.method == :options

    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end


  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_url, alert: t('application.pundit_failure')
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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

  private

  def record_not_found
    flash[:alert] = t('application.record_not_exists')
    redirect_back(fallback_location: root_path)
  end
end
