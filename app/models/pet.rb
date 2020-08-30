class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :applications

  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :sex
end
