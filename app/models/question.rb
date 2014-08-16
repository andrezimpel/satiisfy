class Question < ActiveRecord::Base

  # associations
  belongs_to :project

  # validations
  validates :title, presence: true
  validates :answer, presence: true

  # count view hits
  is_impressionable

  # filter active projects
  scope :active, lambda { where(['published_at IS NOT NULL']) }



  # solr search
  searchable do
    text :title, :answer
    integer :account_id
    # string(:class) { |q| q.class.name.to_s.downcase }
  end
  # account id for question
  def account_id
    self.project.account_id
  end
end
