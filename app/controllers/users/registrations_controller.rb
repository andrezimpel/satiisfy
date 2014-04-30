RegistrationsController < Devise::RegistrationsController


  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
    params.require(:user).permit(:email, :password, profile_attributes: [:firstname, :lastname])
  end
end
