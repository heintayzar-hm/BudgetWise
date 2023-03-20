class Group < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :contract, through: :contract_groups, foreign_key: "group_id"

  validates :name, presence: true, length: { maximum: 50 }
  validate :icon, presence: true, length: { maximum: 100 }
end
