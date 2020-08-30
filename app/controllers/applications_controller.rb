class ApplicationsController < ApplicationController

  def new
    favorite = Favorite.new(session[:favorites])
    @favorite_pets = favorite.pets
  end

  def create
    @application = Applications.new(application_params)
    @pet_ids = params[:favorite][:pet_id].reject!(&:empty?)
    @pets = @pet_ids.map {|id| Pet.find(id)}

    @application.save
    @pets.each {|pet| ApplicationsPet.create(applications: @application, pet: @pet)}
    flash[:notice] = "Submission complete. You're one step closer to becoming a pet owner!"
    redirect_to '/favorites'
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end

end
