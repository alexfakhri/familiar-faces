require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a name" do
    User.create(name: "Panda", email: "pandas@familiarfaces.com", password: "happiness101", password_confirmation: "happiness101")
    user = User.last
    expect(user.name).to eq("Panda")
  end

end
