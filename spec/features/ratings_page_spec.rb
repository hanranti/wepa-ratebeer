require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  #before :each do
  #  visit signin_path
  #  fill_in('username', with:'Pekka')
  #  fill_in('password', with:'Foobar1')
  #  click_button('Log in')
  #end

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "shows ratings and their count at ratings-page" do
    FactoryGirl.create(:rating, score:1, beer:beer1)
    FactoryGirl.create(:rating, score:2, beer:beer2)
    FactoryGirl.create(:rating, score:11, beer:beer2)
    visit ratings_path

    expect(page).to have_content 'iso 3 1'
    expect(page).to have_content 'Karhu 2'
    expect(page).to have_content 'Karhu 11'
    expect(page).to have_content 'amount of ratings 3'
  end
end