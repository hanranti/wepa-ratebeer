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
            rating = Rating.create params.require(:rating).permit(:score, :beer_id)
        end

        # talletetaan tehdyn reittauksen sessioon
        session[:last_rating] = "#{rating.beer.name} #{rating.score} points"

        redirect_to ratings_path
    end

    def destroy
        rating = Rating.find(params[:id])
        rating.delete
        redirect_to ratings_path
    end
end