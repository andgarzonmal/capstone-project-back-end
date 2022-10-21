class User < ApplicationRecord
  has_many :reservations, dependent: :delete_all
  has_many :rooms, through: :reservations, dependent: :delete_all

  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
end
