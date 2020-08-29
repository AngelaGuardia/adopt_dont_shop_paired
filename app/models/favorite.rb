class Favorite
  
  def initialize(pet_ids)
    @pet_ids = pet_ids
  end

  def pets
    @pet_ids.map { |pet_id| Pet.find(pet_id) }
  end
end
