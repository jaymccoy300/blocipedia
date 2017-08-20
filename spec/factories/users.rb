FactoryGirl.define do
  factory :user do
    email {FFaker::Internet.email}
    password {Devise.friendly_token.first(8)}

    factory :admin do
      admin true
    end
  end
end
