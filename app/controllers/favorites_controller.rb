class FavoritesController < ApplicationController
  def index
    if session[:favorites]
      favorite = Favorite.new(session[:favorites])
      @favorite_pets = favorite.pets
    else
      flash[:notice] = "Uh-oh! You haven't favorited any pets yet..."
    end
  end

  def update
    @pet = Pet.find(params[:pet_id])
    session[:favorites] ||= []
    session[:favorites] << params[:pet_id].to_s
    flash[:success] = "#{@pet.name} has been added to your favorites!"
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorite = Favorite.new(session[:favorites])
    session[:favorites].delete(params[:pet_id])
    favorite.remove_pet(params[:pet_id])
    flash[:removed] = "You have removed #{pet.name} from your favorites!"
    redirect_back fallback_location: '/'
  end
end
