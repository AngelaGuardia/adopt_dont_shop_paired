class FavoritesController < ApplicationController

  def new
    @pet = Pet.find(params[:pet_id])
    flash[:success] = "#{@pet.name} has been added to your favorites!"
    session[:favorites] = []
    session[:favorites] << params[:pet_id]
    @number_of_favorites = session[:favorites].count
    redirect_to "/pets/#{params[:pet_id]}"
  end
end
