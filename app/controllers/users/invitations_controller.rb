class Users::InvitationsController < Devise::InvitationsController
  after_filter :add_account_id, only: [:create]
  after_filter :add_person_information, only: [:create]

  # layout
  layout :layout_by_resource
  def layout_by_resource
    if devise_controller? && controller_name == "invitations" && action_name == "edit" || action_name == "update"
      "devise"
    else
      "application"
    end
  end



  def update
    self.resource = accept_resource

    if resource.errors.empty?
      yield resource if block_given?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message :notice, flash_message
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource){ render :edit }
    end
  end

  private

  def add_account_id
    self.resource.account_id = params[:account_id]
    self.resource.save!
  end

  def add_person_information
    user = resource

    user.firstname = params[:user][:firstname] if !params[:user][:firstname].empty?
    user.lastname = params[:user][:lastname] if !params[:user][:lastname].empty?
    user.position = params[:user][:position] if !params[:user][:position].empty?

    user.save!
  end


  protected

  def accept_resource
    resource_class.accept_invitation!(update_resource_params)
  end
end
