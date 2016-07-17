FactoryGirl.define do
  factory :game do
    date    { FFaker::Time.date }
    hosts   { build :lineup }
    guests  { build :lineup }
    scorer  { build :scorer }
    season  { build :season }
  end
end
