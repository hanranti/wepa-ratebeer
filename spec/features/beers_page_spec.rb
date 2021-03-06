require 'rails_helper'

include Helpers

describe "Beer" do 
  before :each do
    FactoryGirl.create :user
    sign_in(username:"Pekka", password:"Foobar1")
  end

  describe "when is being saved" do
    it "is saved if name is valid" do
      visit new_beer_path

      fill_in('beer_name', with:'a')
      #fill_in('beer_style', with:'Weizen')
      #fill_in('beer_brewery_id', with:1)

      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

    it "is not saved when name is not valid" do
      visit new_beer_path

      fill_in('beer_name', with:'')
      
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(0)
      expect(page).to have_content "Name can't be blank"
    end
  end
end