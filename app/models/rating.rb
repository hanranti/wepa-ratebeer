class Rating < ActiveRecord::Base
    belongs_to :beer

    def to_s
        return beer.name.to_s + " " + score.to_s 
    end
end
