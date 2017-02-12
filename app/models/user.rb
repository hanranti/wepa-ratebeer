class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, 
                       length: { minimum: 3,
                                 maximum: 30 }
  validates :password, length: { minimum: 3 },
                       format: { :with => /([A-Z].*\d)|(\d.*[A-Z])/, message:"Password must contain at least 1 capital letter and number." }

  has_many :ratings, dependent: :destroy   # käyttäjällä on monta ratingia
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by{ |r| r.score }.last.beer
  end

  def favorite_style
    return nil if ratings.empty?
    favorite = "Weizen"
    bestAverage = 0;
    ["Weizen", "Lager", "Pale ale", "IPA", "Porter"].each do |style|
      average = average_rating_for_style(style)
      if average > bestAverage
        favorite = style
        bestAverage = average
      end
    end
    favorite
  end

  def to_s
    username
  end
end
