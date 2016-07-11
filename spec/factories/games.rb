FactoryGirl.define do
  factory :game do
    date          { FFaker::Time.date }
    home_team  { build :team }
    away_team  { build :team }
    scorer     { build :scorer }
    season     { build :season }
  end
end
