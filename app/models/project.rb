class Project < ActiveRecord::Base
  belongs_to :competition, inverse_of: :projects
  belongs_to :competitor, class_name: 'Project'
  has_many :memberships, inverse_of: :project, dependent: :destroy
  has_many :collaborators, through: :memberships, source: :user
  has_many :comments, inverse_of: :project, dependent: :destroy
  has_many :sent_transactions, as: :sender, class_name: 'Transaction'
  has_many :received_transactions, as: :recipient, class_name: 'Transaction'

  validates :name, presence: true
  validates :competitor_id, uniqueness: true, allow_nil: true

  after_create :set_competitor_inverse, if: 'competitor.present?'

  def net_points
    received_transactions.sum(:points) - sent_transactions.sum(:points)
  end

  def total_transactions
    received_transactions.size + sent_transactions.size
  end

  def points_per_transaction
    net_points / total_transactions
  end

  private

  def set_competitor_inverse
    competitor.update_attribute :competitor, self
  end
end
