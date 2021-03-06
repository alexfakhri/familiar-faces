require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    user = create(:user)
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

  it "has an email" do
    user = User.last
    expect(user.email).to eq("panda@familiarfaces.co")
  end

  it "has an avatar" do
    user = User.last
    expect(user.avatar_file_name).to eq("panda.jpg")
  end

  it "has a default role of contributor" do
    user = User.last
    expect(user.role).to eq("contributor")
  end

  it "can become an admin user" do
    user = User.last
    user.role = 'admin'
    expect(user.role).to eq("admin")
  end

  it 'must enter a first name' do
    user = User.new(last_name: "panda")
    expect(user).to have(1).error_on(:first_name)
    expect(user).not_to be_valid
  end

  it 'must enter a lanst name' do
    user = User.new(first_name: "pop")
    expect(user).to have(1).error_on(:last_name)
    expect(user).not_to be_valid
  end

end
