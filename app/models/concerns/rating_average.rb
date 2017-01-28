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
end