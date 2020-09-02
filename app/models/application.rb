class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :phone_number
  validates_presence_of :description

  def add_pets(pet_ids)
    clean(pet_ids).each do |pet_id|
      self.pets << Pet.find(pet_id)
    end
  end

  def clean(pet_ids)
    pet_ids.reject!(&:empty?)
  end
end
