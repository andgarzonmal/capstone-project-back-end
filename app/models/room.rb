class Room < ApplicationRecord
  has_many :reservations, dependent: :delete_all
  has_many :users, through: :reservations

  validates :name, :description, :photo, presence: true
  validates :name, length: { maximum: 200 }
  validates :description, length: { maximum: 2000 }
end
