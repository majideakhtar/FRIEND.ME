class ApplicationController < ActionController::Base
	# protect_from_forgery with: :exception
	protect_from_forgery with: :null_session
	before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters    # Permit the `subscribe_newsletter` parameter along with the other
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile_image, :gender, :dob, :mobile, :likes, :dislikes, :city])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_image, :gender, :dob, :mobile, :likes, :dislikes, :city])
  end
end
