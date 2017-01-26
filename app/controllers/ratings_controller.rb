class RatingsController < ApplicationController
    def index
        @ratings = Rating.all
        @beers = Beer.all
    end
end