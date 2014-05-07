class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  belongs_to :account
  has_one :profile


  # userstamps
  model_stamper

  accepts_nested_attributes_for :profile


  # create profile after creating a user
  after_create :create_profile
  def create_profile
    p = Profile.new
    p.user_id = self.id
    p.save
  end


  # get user "Name"
  def fullname
    if self.profile
      if self.profile.firstname != nil && self.profile.lastname != nil
        return self.profile.firstname + " " + self.profile.lastname
      end
      return self.email
    end
    return self.email
  end
end
