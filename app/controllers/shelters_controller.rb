class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if !shelter.save
      flash[:failure] = "Oh no! Please fill out missing fields before hitting the submit button."
      redirect_to '/shelters/new'
    else
      redirect_to '/shelters'
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.assign_attributes(shelter_params)
    if !shelter.save
      flash[:failure] = "Oh no! Please fill out missing fields before hitting the submit button."
      redirect_to "/shelters/#{shelter.id}/edit"
    else
      redirect_to "/shelters/#{shelter.id}"
    end
  end

  # create = new + save
  # update = asssign_attributes + save

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.has_all_adoptable_pets?
      shelter.delete_pets
      shelter.delete_reviews
      shelter.destroy
    end
    redirect_to '/shelters'
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
