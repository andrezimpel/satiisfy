class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
  before_action :authenticate_user!

  # store user login info in cookie for fast-login  & redirect after login
  def after_sign_in_path_for(resource)

    cookies["satiisfy_user_id"] = {
      :value => current_user.id,
      :expires => 2.days.from_now
    }


    satiisfy_root_path(current_user.account)
  end


  def redirect_to_with_logging(*args)
    logger.debug "Redirect: #{args.inspect} from #{caller[0]}"
    redirect_to_without_logging *args
  end
  alias_method_chain :redirect_to, :logging

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
end
