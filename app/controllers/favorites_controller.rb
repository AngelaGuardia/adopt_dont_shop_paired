class FavoritesController < ApplicationController

  def index
    favorite = Favorite.new(session[:favorites])
    @favorite_pets = favorite.pets
  end

  def update
    @pet = Pet.find(params[:pet_id])
    session[:favorites] ||= []
    session[:favorites] << params[:pet_id].to_s
    flash[:success] = "#{@pet.name} has been added to your favorites!"
    redirect_to "/pets/#{params[:pet_id]}"
  end
end
