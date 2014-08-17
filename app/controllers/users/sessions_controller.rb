class Users::SessionsController < Devise::SessionsController
  def new

    if cookies[:satiisfy_fast_login_id] != nil
      @login = User.where(fast_login_id: (cookies[:satiisfy_fast_login_id])).first
    end

    super
  end
end
