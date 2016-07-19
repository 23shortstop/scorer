FactoryGirl.define do
  factory :game do
    date    { FFaker::Time.date }
    hosts   { create :lineup }
    guests  { create :lineup }
    scorer  { build :scorer }
    season  { build :season }
  end
end
