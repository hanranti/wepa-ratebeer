require 'rails_helper'

#RSpec.describe Beer, type: :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end

RSpec.describe Beer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "is saved if params are valid" do
    beer = Beer.create name: "beer", style: "Weizen"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved if it does not have name" do
    beer = Beer.create style: "Weizen"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved if it does not have style" do
    beer = Beer.create name: "beer"

    #expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
