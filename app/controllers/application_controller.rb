class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # filters
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  # layout
  layout :layout_by_resource
  def layout_by_resource
    if devise_controller? && controller_name != "invitations"
      "devise"
    else
      "application"
    end
  end


  # userstamps
  include Userstamp


  # devise


  # store user login info in cookie for fast-login  & redirect after login
  def after_sign_in_path_for(resource)

    # gerate fast login id
    fast_login_id = SecureRandom.hex(64)

    # set fast login id cookie
    cookies["satiisfy_fast_login_id"] = {
      :value => fast_login_id,
      :expires => 2.days.from_now
    }

    # save fast login id in user
    current_user.update_attribute :fast_login_id, fast_login_id

    satiisfy_root_path(current_user.account)
  end


  # current account
  before_filter :set_current_account
  def set_current_account
    # get account by scoped :account_id

    if params[:account_id]
      @current_account = Account.find(params[:account_id])
      return @current_account
    end

    # redirect to the user account if there is no account id
    if current_user
      return redirect_to satiisfy_root_path(current_user.account) unless controller_name == "sessions" && action_name == "create"
    end

    # dont' raise the exception if we are in the devise stuff
    if !devise_controller?
      raise ActionController::RoutingError.new('Account not found.')
    end
  end

  # default url options
  def default_url_options(options={})
    if @current_account.present?
      { :account_id => @current_account.id }
    else
      { :account_id => nil }
    end
  end



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:fast_login_id, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :fast_login_id, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:fast_login_id, :email, :password, :password_confirmation, :current_password) }
  end
end
