class User < ActiveRecord::Base

  default_scope { order('invitation_token ASC', 'firstname ASC') }

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


  # inviteable stat
  def status
    return 'invited' if self.invitation_token
    return 'active' if self.last_sign_in_at
  end

  def is_active?
    if self.status  == "active"
      return true
    end
    return false
  end

  def is_invited?
    if self.status  == "invited"
      return true
    end
    return false
  end


  # get user "Name"
  def fullname
    # return real fullname
    if self.firstname != nil && self.lastname != nil
      return self.firstname + " " + self.lastname
    end

    # return fristname if available
    return self.firstname unless self.firstname == nil

    # return email
    return self.email
  end

  # get user firstname with email fallback
  def firstname_fallback
    # return fristname if available
    return self.firstname unless self.firstname == nil

    # return email
    return self.email
  end
end
