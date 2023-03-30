class Contract < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :contract_groups, dependent: :destroy
  has_many :groups, through: :contract_groups, dependent: :destroy, foreign_key: 'contract_id'
  attr_accessor :group_id

  def human_date
    created_at.strftime('%d %B %Y')
  end
  validates :name, presence: true, length: { maximum: 50 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
