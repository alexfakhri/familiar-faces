require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    User.create(first_name: "Happy", last_name: "Panda", email: "pandas@familiarfaces.com",
    password: "happiness101", password_confirmation: "happiness101", bio: "I am a happy panda")
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
