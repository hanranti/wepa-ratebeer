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

  def to_s
    username
  end
end
