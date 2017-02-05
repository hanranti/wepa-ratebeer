class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @beers = Beer.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    if (!Beer.find_by(id: params[:rating][:beer_id]).nil?)
      @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    end

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end

    # talletetaan tehdyn reittauksen sessioon
    #session[:last_rating] = "#{rating.beer.name} #{rating.score} points"

    #redirect_to ratings_path
    end

    def destroy
        rating = Rating.find(params[:id])
        rating.delete if current_user == rating.user
        redirect_to :back
    end
end