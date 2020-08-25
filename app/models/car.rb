class Car < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :car_model

  validates :license_plate, :color, :mileage, presence: true
  validates :license_plate, uniqueness: true
  validates :mileage, numericality: { greater_than_or_equal_to: 0 }
 
end
