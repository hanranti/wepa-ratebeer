class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def to_s
    name.to_s + " (" + brewery.name.to_s + ")"
  end
end
