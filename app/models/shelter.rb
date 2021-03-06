class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def has_all_adoptable_pets?
    self.pets.all? { |pet| pet.adoption_status == "Adoptable" }
  end

  def delete_pets
    self.pets.each do |pet|
      delete_applications(pet)
      pet.destroy
    end
  end

  def delete_applications(pet)
    pet.applications.each do |application|
      application.pets.delete(pet)
    end
  end

  def delete_reviews
    self.reviews.each { |review| review.destroy }
  end

  def pets_count
    self.pets.count
  end

  def avg_shelter_review
    Review.average(:rating)
  end

  def applications_count
    self.pets.sum do |pet|
      pet.applications.count
    end
  end
end
