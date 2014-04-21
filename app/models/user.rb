class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :account
  has_one :profile


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
