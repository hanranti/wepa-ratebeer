require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do

    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "shows ratings in user page" do
      sign_in(username:"Pekka", password:"Foobar1")

      beer = FactoryGirl.create :beer, name:"beer"
      FactoryGirl.create :rating, user:User.first, beer:beer, score:12

      user2 = FactoryGirl.create(:user, username:"Pekka2")
      beer2 = FactoryGirl.create :beer, name:"beer2"
      FactoryGirl.create :rating, user:user2, beer:beer2, score:9

      visit user_path(User.first)

      expect(page).to have_content 'beer 12'
      expect(page).not_to have_content 'beer2 9'

      visit user_path(user2)

      expect(page).to have_content 'beer2 9'
      expect(page).not_to have_content 'beer 12'
  end

  it "deletes rating" do
    sign_in(username:"Pekka", password:"Foobar1")

    beer = FactoryGirl.create :beer, name:"beer"
    rating = FactoryGirl.create :rating, user:User.first, beer:beer, score:12
    beer2 = FactoryGirl.create :beer, name:"beer2"
    FactoryGirl.create :rating, user:User.first, beer:beer2, score:11

    visit user_path(User.first)
    expect(page).to have_content 'beer 12'

    page.find("a", :class => "#{beer.name}").click_link('Delete')
      
    expect(page).not_to have_content 'beer 12'
  end

  describe "when has ratings" do

    before :each do
      brewery1 = FactoryGirl.create :brewery, name:"brewery1"
      brewery2 = FactoryGirl.create :brewery, name:"brewery2"
      brewery3 = FactoryGirl.create :brewery, name:"brewery3"
      beer1 = FactoryGirl.create :beer, name:"beer1", style:"Weizen", brewery:brewery1
      beer2 = FactoryGirl.create :beer, name:"beer2", style:"Weizen", brewery:brewery2
      beer3 = FactoryGirl.create :beer, name:"beer3", style:"Lager", brewery:brewery2
      beer4 = FactoryGirl.create :beer, name:"beer4", style:"Lager", brewery:brewery3
      beer5 = FactoryGirl.create :beer, name:"beer5", style:"Porter", brewery:brewery3
      FactoryGirl.create :rating, score:10, beer:beer1, user:User.first
      FactoryGirl.create :rating, score:15, beer:beer2, user:User.first
      FactoryGirl.create :rating, score:20, beer:beer3, user:User.first
      FactoryGirl.create :rating, score:25, beer:beer4, user:User.first
      FactoryGirl.create :rating, score:30, beer:beer5, user:User.first
    end

    it "has correct favorite style" do
      visit user_path(User.first)
      expect(page).to have_content 'favorite style: Porter'
    end

    it "has correct favorite brewery" do
      visit user_path(User.first)
      expect(page).to have_content 'favorite brewery: brewery3'
    end
  end
end