class Question < ActiveRecord::Base

  belongs_to :project

  validates :title, presence: true
  validates :answer, presence: true

  is_impressionable

  # filter active projects
  scope :active, lambda { where(['published_at IS NOT NULL']) }
end
