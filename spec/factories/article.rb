FactoryGirl.define do
  factory :article do
    association :user

    title                 "Panda goes to Brazil"
    story                 "A night out in Rio"
    location              "Brazil"
    photo {fixture_file_upload( File.join(Rails.root, 'spec', 'helpers', 'images', 'panda.jpg'), 'image/jpeg')}

    trait :south_america do
      after(:create) { |article| article.update_attributes(tag_list: 'South America') }
    end

  end
end
