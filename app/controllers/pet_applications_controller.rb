class PetApplicationsController < ApplicationController
  def update
    pet = Pet.find(strong_params[:pet_id])
    application = Application.find(strong_params[:application_id])
    if pet.adoption_status == "Adoptable"
      pet.update(adoption_status: "Pending - on hold for: #{application.name}")
      redirect_to "/pets/#{pet.id}"
    else
      pet.update(adoption_status: "Adoptable")
      redirect_to "/applications/#{application.id}"
    end
  end

  private

  def strong_params
    params.permit(:pet_id, :application_id)
  end
end
