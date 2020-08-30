class Favorite
  def initialize(pet_ids)
    @pet_ids = pet_ids
  end

  def pets
    @pet_ids.map { |pet_id| Pet.find(pet_id) }
  end

  def remove_pet(pet_id)
    @pet_ids.delete(pet_id)
  end

  def remove_all
    @pet_ids = nil
  end
end
