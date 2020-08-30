class ApplicationsController < ApplicationController

  def new
    favorite = Favorite.new(session[:favorites])
    @favorite_pets = favorite.pets
  end

end
