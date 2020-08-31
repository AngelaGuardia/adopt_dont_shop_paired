class ApplicationsController < ApplicationController
  def index
    @pet = Pet.find(pet_params[:pet_id])
  end

  def new
    favorite = Favorite.new(session[:favorites])
    @favorite_pets = favorite.pets
  end

  def create
    application = Application.new(application_params)
    if application.save
      application.add_pets(favorite_params)
      flash[:success] = "Submission complete. You're one step closer to becoming a pet owner!"
      redirect_to "/favorites"
    else
      flash[:failure] = "Oh no! Please fill out missing fields before hitting the submit button."
      redirect_to "/applications/new"
    end
  end

  def show
    favorite = Favorite.new(session[:favorites])
    @favorite_pets = favorite.pets
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description, :favorite)
  end

  def favorite_params
    params[:favorite].permit(:pet_id => [])[:pet_id]
  end

  def pet_params
    params.permit(:pet_id)
  end
end
