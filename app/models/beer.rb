class Beer < ActiveRecord::Base
    belongs_to :brewery
    has_many :ratings

    def average_rating
        average = 0
        self.ratings.each do |rating|
            average += rating.score
        end
        average /= self.ratings.count
    end
end
