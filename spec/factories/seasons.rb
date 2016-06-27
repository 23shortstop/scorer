FactoryGirl.define do
  factory :season do
    league  { create :league }
    year    { Faker::Number.between(1900, 2100) }
  end
end