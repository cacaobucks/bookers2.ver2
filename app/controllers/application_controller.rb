class ApplicationController < ActionController::Base
 before_action :authenticate_user!, except: [:top,:about]
 before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user.id, notice: 'Signed in successfully.')
  end

  def after_sign_out_path_for(resource)
    root_path(notice: 'Signed out successfully.')
  end

  def after_sign_up_path_for(resource)
    user_path(current_user.id, notice: 'Welcome! You have signed up successfully.')
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end


end