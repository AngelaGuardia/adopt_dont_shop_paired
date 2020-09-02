class ApplicationsController < ApplicationController
  def index
    @pet = Pet.find(pet_params[:pet_id])
    if @pet.applications.empty?
      flash[:notice] = "There are no applications for #{@pet.name} yet!"
    end
  end

  def new
    favorite = Favorite.new(session[:favorites])
    @favorite_pets = favorite.pets(session[:favorites])
  end

  def create
    application = Application.new(application_params)
    if application.save
      application.add_pets(favorite_params)
      session[:applied_pets] =  application.clean(favorite_params)
      flash[:success] = "Submission complete. You're one step closer to becoming a pet owner!"
      redirect_to "/favorites"
    else
      flash[:failure] = "Oh no! Please fill out missing fields before hitting the submit button."
      redirect_to "/applications/new"
    end
  end

  def show
    @application = Application.find(id_params[:id])
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

  def id_params
    params.permit(:id)
  end
end
