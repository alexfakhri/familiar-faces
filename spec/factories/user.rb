FactoryGirl.define do
  factory :user do

    first_name            "Happy"
    last_name             "Panda"
    email                 "panda@familiarfaces.co"
    password              "happiness101"
    password_confirmation "happiness101"
    confirmed_at          Time.now
  end
end
