class FavoritesController < ApplicationController
  def index
    if session[:favorites] || session[:applied_pets]
      favorite = Favorite.new(session[:favorites])
      if session[:applied_pets]
        session[:favorites] -= session[:applied_pets]
        @applied_pets = favorite.pets(session[:applied_pets])
      end
      @favorite_pets = favorite.pets(session[:favorites])
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
    favorite = Favorite.new(session[:favorites])
    if params[:pet_id]
      pet = Pet.find(params[:pet_id])
      session[:favorites].delete(params[:pet_id])
      favorite.remove_pet(params[:pet_id])
      flash[:removed] = "You have removed #{pet.name} from your favorites!"
      redirect_back fallback_location: '/'
    else
      session[:favorites] = nil
      favorite.remove_all
      redirect_to '/favorites'
    end
  end
end
