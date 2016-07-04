FactoryGirl.define do
  factory :league do
    league_name  { FFaker::Company.name }
  end
end
