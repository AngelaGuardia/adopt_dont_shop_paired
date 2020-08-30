class Applications < ApplicationRecord

  belongs_to :shelter
  has_many :pet_applications
  has_many :pets, through: :applications

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :phone_number
  validates_presence_of :description
end
