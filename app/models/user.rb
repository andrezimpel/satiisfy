class User < ActiveRecord::Base
  # userstamps
  model_stamper

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable,
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  # associations
  belongs_to :account

  # paperclip
  has_attached_file :avatar,
    :styles => {
      :extra_large => "1200x1200>",
      :large => "600x600>",
      :medium => "300x300>",
      :thumb => "150x150>",
      :tiny => "75x75>",
      :extra_large_square => "1200x1200#",
      :large_square => "600x600#",
      :medium_square => "300x300#",
      :thumb_square => "150x150#",
      :tiny_square => "75x75#"
    },
    :default_url => "/assets/default_avatar.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  # get user "Name"
  def fullname
    # if self.profile
    #   if self.profile.firstname != nil && self.profile.lastname != nil
    #     return self.profile.firstname + " " + self.profile.lastname
    #   end
    #   return self.email
    # end
    # return self.email
  end
end
