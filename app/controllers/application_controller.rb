class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def after_sign_in_path_for resource
    current_user.admin? ? admin_root_path : activities_path(user_id: current_user.id)
  end

  def required_admin
    authenticate_user!
    redirect_to root_path unless current_user.admin?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) {|u| u.permit :signin}
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit :email,
      :name, :password, :password_confirmation}
  end
end
