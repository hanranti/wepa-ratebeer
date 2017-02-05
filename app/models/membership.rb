class Membership < ActiveRecord::Base
  validates :user, presence:true, 
                   uniqueness: {scope: :beer_club}
  validates :beer_club, presence: true

  belongs_to :user
  belongs_to :beer_club
end
