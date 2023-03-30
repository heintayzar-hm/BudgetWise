class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :groups, foreign_key: 'author_id', dependent: :destroy
  has_many :contracts, foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  def admin?
    role == 'admin'
  end
end
