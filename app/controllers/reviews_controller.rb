class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    review = Review.new(review_params)
    if review.save
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:notice] = "Review not created: Required information missing."
      redirect_to "/shelters/#{params[:shelter_id]}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    if review.update(review_params)
      redirect_to "/shelters/#{review.shelter.id}"
    else
      flash[:notice] = "Review not created: Required information missing."
      redirect_to "/reviews/#{review.id}/edit"
    end
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :picture, :shelter_id)
  end
end
