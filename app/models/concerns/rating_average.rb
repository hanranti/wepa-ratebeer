module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    #ei toimi
#      average = ratings.inject { |rating, n| rating.score + n }
#      average /= ratings.count

#       scores = Array.new;
#       ratings.each do |rating| 
#         scores << rating.score
#       end
#       average = scores.inject {|score, n| score + n}
#       average /= scores.count.to_f

#       average = 0;
#       ratings.each do |rating|
#           average += rating.score
#       end
#       average /= ratings.count

        ratings.average(:score)
  end

  def average_rating_for_style_and_brewery(style, brewery)
    if style.nil? && !brewery.nil?
      ratingsWithStyleAndBrewery = ratings.select{|rating| rating.beer.brewery.eql? brewery}
    elsif brewery.nil? && !style.nil?
      ratingsWithStyleAndBrewery = ratings.select{|rating| rating.beer.style.eql? style}
    elsif brewery.nil? && style.nil?
      ratingsWithStyleAndBrewery = ratings
    else 
      ratingsWithStyleAndBrewery = ratings.select{|rating| rating.beer.style.eql? style}
      ratingsWithStyleAndBrewery = ratingsWithStyleAndBrewery.select{|rating| rating.beer.brewery.eql? brewery}
    end
    if ratingsWithStyleAndBrewery.count == 0
      return 0;
    else
      
    end
    scores = Array.new
    ratingsWithStyleAndBrewery.each do |rating|
      scores << rating.score
    end
    average = scores.inject {|score, n| score + n}
    average /= scores.count.to_f
  end
end