class Contract < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :contracts, through: :contract_groups, foreign_key: "contract_id"

  validates :name, presence: true, length: { maximum: 50 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
