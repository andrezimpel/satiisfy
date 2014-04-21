class Account < ActiveRecord::Base

  has_many :projects
  has_many :users
  has_many :profiles, through: :users
end
