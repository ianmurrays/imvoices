FactoryGirl.define do
  factory :user do
    name "John"
    
    sequence :email do |n|
      "john#{n}@example.org"
    end
    
    password "john123"
    password_confirmation "john123"
  end
end