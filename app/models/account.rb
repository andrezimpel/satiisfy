class Account < ActiveRecord::Base

  has_many :projects
  has_many :users
  has_many :profiles, through: :users

  accepts_nested_attributes_for :users

  # validations
  validates :title, presence: true
end
