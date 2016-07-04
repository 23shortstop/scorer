FactoryGirl.define do
  factory :scorer do
    name      { FFaker::Name.name }
    email     { FFaker::Internet.email }
    password  { FFaker::Internet.password }
  end
end
