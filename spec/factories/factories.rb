FactoryGirl.define do
  factory :user do
    sequence(:name)       { |n| "Person #{n}" }
    sequence(:email)      { |n| "person_#{n}@richardshin.com" }
    provider              'facebook'
    sequence(:uid)        { |n| "uid#{n}" }
    sequence(:token)      { |n| "token#{n}" }
    avatar_url            { 'https://secure.gravatar.com/avatar/4576585a7a1eaa2edc8445ac71f3c55d' }
  end
end