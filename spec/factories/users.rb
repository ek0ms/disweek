FactoryGirl.define do
  factory :user do
    sequence(:nickname) { |n| "user#{n}" }
    sequence(:uid) { |n| "315318950#{n}" }
    provider "instagram"
    pic "https://scontent.cdninstagram.com/t51.2885-19/11906329_960233084022564_1448528159_a.jpg"
  end
end
