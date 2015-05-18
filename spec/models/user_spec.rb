require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    user = FactoryGirl.create(:user)
  end

  it "has a name" do
    user = User.last
    expect(user.first_name).to eq("Happy")
    expect(user.last_name).to eq("Panda")
  end

  it "has a bio" do
    user = User.last
    expect(user.bio).to eq("I am a happy panda")
  end

end
