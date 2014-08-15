class Account < ActiveRecord::Base

  has_many :projects
  has_many :users

  accepts_nested_attributes_for :users

  # validations
  validates :title, presence: true
end
