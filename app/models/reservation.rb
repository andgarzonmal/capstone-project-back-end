class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :city, presence: true
  validates :date, presence: true
end
