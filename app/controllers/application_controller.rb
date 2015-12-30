class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :current_user_overdue_penalty
  before_filter :current_user_active?
  before_filter :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:full_name, :email, :password, :remember_me) }
  end

  def current_user_overdue_penalty
    if user_signed_in? && current_user.overdue_penalty > 0
      flash.now[:error] = "Please Pay your penalty for not returning the stationeries that you\'ve borowed. Your penalty is USD #{current_user.overdue_penalty}"
    end
  end

  def current_user_active?
    if user_signed_in? && current_user.deactived? && !devise_controller?
      redirect_to destroy_user_session_path
    end
  end
end
