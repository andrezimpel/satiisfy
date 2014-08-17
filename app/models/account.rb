class Account < ActiveRecord::Base

  has_many :users
  has_many :projects
  has_many :questions, :through => :projects

  accepts_nested_attributes_for :users

  # validations
  validates :title, presence: true, uniqueness: true
end
