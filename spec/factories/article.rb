FactoryGirl.define do
  factory :article do
    association :user

    title                 "Panda goes to Brazil"
    story                 "A night out in Rio"
    # contributor

  end
end
