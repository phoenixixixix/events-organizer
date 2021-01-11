class ApplicationController < ActionController::Base
  helper_method :current_user_can_edit?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user_can_edit?(model)
    user_signed_in? && (
      model.user == current_user ||
        (model.try(:event).present? && model.event.user == current_user)
    )
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :current_password])
  end
end
