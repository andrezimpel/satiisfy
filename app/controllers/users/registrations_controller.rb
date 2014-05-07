class Users::RegistrationsController < Devise::RegistrationsController


  def account_update_params

    # params.require(:user).permit(:password, :password_confirmation, :current_password, profile: [:firstname, :lastname])

  #   #
  #
  # devise_parameter_sanitizer.for(:account_update) do |u|
  #   u.permit(:password, :password_confirmation, :current_password, profile_attributes: [:firstname, :lastname])
  # end

  devise_parameter_sanitizer.sanitize(:account_update)
  #   #
  #   # # params.require(:user).permit(:email, :password, profile_attributes: [:firstname, :lastname])
  #   # raise "i"
  #   # super
  #
  #   raise "hi"

  end
end
