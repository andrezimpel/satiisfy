class Users::InvitationsController < Devise::InvitationsController
  after_filter :add_account_id, only: [:create]
  after_filter :add_person_information, only: [:create]

  # layout "devise"

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
end
