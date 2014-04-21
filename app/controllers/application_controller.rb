class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # layout
  layout :layout_by_resource
  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end



  # devise
  before_action :authenticate_user!

  # redirect after login
  def after_sign_in_path_for(resource)
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

    # dont' raise the exception if we are in the devise stuff
    if !devise_controller?
      raise "Account not found."
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
