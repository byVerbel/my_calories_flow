class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[firstname lastname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[firstname lastname])
  end

  def after_sign_in_path_for(_resource)
    dashboard_index_path
  end
end
