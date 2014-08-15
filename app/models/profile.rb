class Profile < ActiveRecord::Base
  belongs_to :user

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

  # get fullname
  def fullname
    self.user.fullname
  end
end
