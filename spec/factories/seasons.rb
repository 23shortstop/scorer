FactoryGirl.define do
  factory :season do
    league  { build :league }
    year    { rand(1900..2100) }
  end
end