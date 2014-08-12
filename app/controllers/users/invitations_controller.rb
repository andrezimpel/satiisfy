class Users::InvitationsController < Devise::InvitationsController
  after_filter :add_account_id, only: [:create]
  after_filter :add_person_information, only: [:update]

  layout "devise"

  def add_account_id
    self.resource.account_id = params[:account_id]
    self.resource.save!
  end

  def add_person_information
    user = resource
    profile = user.profile

    profile.firstname = params[:user][:profile][:firstname] if !params[:user][:profile][:firstname].empty?

    profile.lastname = params[:user][:profile][:lastname] if !params[:user][:profile][:lastname].empty?

    profile.save!
  end
end
