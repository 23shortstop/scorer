FactoryGirl.define do
  factory :season do
    league  { build :league }
    year    { Faker::Number.between(1900, 2100) }
  end
end