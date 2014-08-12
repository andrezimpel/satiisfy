class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # layout
  layout :layout_by_resource
  def layout_by_resource
    if devise_controller? || params[:controller] == "users/invitations"
      "devise"
    else
      "application"
    end
  end


  # userstamps
  include Userstamp


  # devise
  before_action :authenticate_user!

  # store user login info in cookie for fast-login  & redirect after login
  def after_sign_in_path_for(resource)
    # cookies["satiisfy_user_id"] = {
    #   :value => current_user.id,
    #   :expires => 2.days.from_now
    # }

    super

    # satiisfy_root_path(current_user.account)
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
      return redirect_to satiisfy_root_path(current_user.account)
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
end
