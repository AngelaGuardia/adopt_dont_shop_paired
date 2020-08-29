class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def filter_by_shelter
    @shelter = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets
  end

  def show
    @pet = Pet.find(params[:pet_id])
    if session[:favorites] != nil
      @favorites = session[:favorites]
    else
      @favorites = []
    end
    # require "pry"; binding.pry
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    pet = Pet.create!(pet_params)
    pet.update(adoption_status: 'Adoptable')
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  def edit
    @pet = Pet.find(params[:pet_id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet.update(pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    pet.destroy
    redirect_to '/pets'
  end

  private
  def pet_params
    params.permit(:image, :name, :age, :description, :sex, :shelter_id, :adoption_status)
  end
end
