require 'faker'

FactoryGirl.define do
  factory :user do

    first_name            "Happy"
    last_name             "Panda"
    email                 Faker::Internet.email
    password              "happiness101"
    password_confirmation "happiness101"
    bio                   "I am a happy panda"
    avatar {fixture_file_upload( File.join(Rails.root, 'spec', 'helpers', 'images', 'panda.jpg'), 'image/jpeg')}
    confirmed_at          Time.now
    initialize_with {User.find_or_create_by(first_name: 'Happy')}
  end

  factory :admin_user, parent: :user do
    after(:build) { |user| user.role = 'admin' }
  end

end
