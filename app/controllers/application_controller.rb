class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :public_page?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def public_page?
    controller_name == 'splash' && action_name == 'index'
  end

  def after_sign_in_path_for(_resource)
    groups_path # groups path
  end

  def after_sign_out_path_for(_resource)
    root_path # splash path
  end
end
