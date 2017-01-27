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
            Rating.create params.require(:rating).permit(:score, :beer_id)
        end
        redirect_to ratings_path
    end
end