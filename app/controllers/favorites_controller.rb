class FavoritesController < ApplicationController

  def new
    @pet = Pet.find(params[:pet_id])
    flash[:success] = "#{@pet.name} has been added to your favorites!"
    session[:favorites] ||= []
    session[:favorites] << @pet
    redirect_to "/pets/#{params[:pet_id]}"
  end
end
