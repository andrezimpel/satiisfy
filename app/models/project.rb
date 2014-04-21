class Project < ActiveRecord::Base

  belongs_to :account
  has_many :questions

  validates :subdomain, presence: true, uniqueness: true
  validates :title, presence: true
  validates :description, presence: true

  is_impressionable
end
