class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :contract_groups, dependent: :destroy
  has_many :contracts, through: :contract_groups, dependent: :destroy, foreign_key: 'group_id'
  has_one_attached :icon

  # for temporary group id
  validate :icon_type
  validates :name, presence: true, length: { maximum: 50 }

  def human_date
    created_at.strftime('%d %B %Y')
  end

  def total
    contracts.sum(:amount)
  end

  private

  def icon_type
    return unless icon.attached? && !icon.content_type.in?(%w[image/jpeg image/png])

    errors.add(:icon, 'needs to be a jpeg or png!')
  end
end
