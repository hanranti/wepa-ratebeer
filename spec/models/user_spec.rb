require 'rails_helper'

#RSpec.describe User, type: :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is saved with a proper password" do
    user = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"

    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
  end

#  describe "with a proper password" do
#    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }
#
#    it "is saved" do
#      expect(user).to be_valid
#      expect(User.count).to eq(1)
#    end
#
#    it "and with two ratings, has the correct average rating" do
#      rating = Rating.new score:10
#      rating2 = Rating.new score:20
#
#      user.ratings << rating
#      user.ratings << rating2
#
#      expect(user.ratings.count).to eq(2)
#      expect(user.average_rating).to eq(15.0)
#    end
#  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  it "validates password" do
    user = User.create username:"kayttajatunnus", password:"a1", password_confirmation:"a1"
    user2 = User.create username:"kayttajatunnus2", password:"salasanA", password_confirmation:"salasanA"

    expect(User.count).to eq(0)
    expect(user).not_to be_valid
    expect(user2).not_to be_valid
  end

#  it "has method for determining the favorite_beer" do
#    user = FactoryGirl.create(:user)
#    expect(user).to respond_to(:favorite_beer)
#  end
#
#   it "without ratings does not have a favorite beer" do
#    user = FactoryGirl.create(:user)
#    expect(user.favorite_beer).to eq(nil)
#  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      #beer1 = FactoryGirl.create(:beer)
      #beer2 = FactoryGirl.create(:beer)
      #beer3 = FactoryGirl.create(:beer)
      #rating1 = FactoryGirl.create(:rating, beer:beer1, user:user)
      #rating2 = FactoryGirl.create(:rating, score:25,  beer:beer2, user:user)
      #rating3 = FactoryGirl.create(:rating, score:9, beer:beer3, user:user)

      #expect(user.favorite_beer).to eq(beer2)

      #create_beer_with_rating(user, 10)
      #best = create_beer_with_rating(user, 25)
      #create_beer_with_rating(user, 7)

      #expect(user.favorite_beer).to eq(best)

      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings_and_style_and_brewery(user, 10, 20, 15, 7, 9, "Weizen", nil)
      create_beers_with_ratings_and_style_and_brewery(user, 11, 21, 16, 8, 10, "Lager", nil)

      expect(user.favorite_style).to eq("Lager")
    end
  end

  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }
    let(:brewery){FactoryGirl.create(:brewery)}

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer, brewery:brewery)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_brewery).to eq(brewery)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings_and_style_and_brewery(user, 10, 20, 15, 7, 9, "Lager", brewery)
      create_beers_with_ratings_and_style_and_brewery(user, 11, 21, 16, 8, 10, "Lager", brewery)

      expect(user.favorite_brewery).to eq(brewery)
    end
  end
end

def create_beer_with_rating(user, score)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(user, *scores)
  scores.each do |score|
    create_beer_with_rating(user, score)
  end
end

def create_beer_with_rating_and_style_and_brewery(user, score, style, brewery)
  beer = FactoryGirl.create(:beer, style:style, brewery:brewery)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings_and_style_and_brewery(user, *scores, style, brewery)
  scores.each do |score|
    create_beer_with_rating_and_style_and_brewery(user, score, style, brewery)
  end
end

#def create_beer_with_rating_and_brewery(user, score, brewery)
#  beer = FactoryGirl.create(:beer, brewery:brewery)
#  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
#  beer
#end
#
#def create_beers_with_ratings_and_brewery(user, *scores, brewery)
#  scores.each do |score|
#    create_beer_with_rating_and_brewery(user, score, brewery)
#  end
#end