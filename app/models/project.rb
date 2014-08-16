class Project < ActiveRecord::Base

  belongs_to :account
  has_many :questions

  validates :subdomain, presence: true, uniqueness: true
  validates :title, presence: true
  validates :description, presence: true

  is_impressionable

  # filter active projects
  scope :active, lambda { where(['active IS TRUE']) }

  # solr search
  searchable do
    text :title, :description
    integer :account_id
    # string :class
  end
end
