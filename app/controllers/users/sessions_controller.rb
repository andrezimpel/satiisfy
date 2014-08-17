class Users::SessionsController < Devise::SessionsController
  def new

    if cookies[:satiisfy_user_id] != nil
      @login = User.find(cookies[:satiisfy_user_id])
    end

    super
  end
end
