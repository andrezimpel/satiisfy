class Question < ActiveRecord::Base

  belongs_to :project

  validates :title, presence: true
  validates :answer, presence: true

  is_impressionable
end
