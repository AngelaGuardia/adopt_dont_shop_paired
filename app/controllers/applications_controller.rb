class ApplicationsController < ApplicationController

  def new
    favorite = Favorite.new(session[:favorites])
    @favorite_pets = favorite.pets
  end

  def create
    application = Applications.new(application_params)
    pet_ids = params[:favorite][:pet_id].reject!(&:empty?)
    pets = pet_ids.map {|id| Pet.find(id)}
    if application.save
      pets.each {|pet| ApplicationsPet.create(applications: application, pet: pet)}
      flash[:success] = "Submission complete. You're one step closer to becoming a pet owner!"
      redirect_to "/favorites"
    else
      flash[:failure] = "Oh no! Please fill out missing fields before hitting the submit button."
      redirect_to "/applications/new"
    end
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end

end
