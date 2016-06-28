FactoryGirl.define do
  factory :season do
    league  { build :league }
    year    { Faker::Number.between(1900, 2100) }
    teams   { build_list :team, 10 }
  end
end