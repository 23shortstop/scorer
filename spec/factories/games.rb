FactoryGirl.define do
  factory :game do
    date          { FFaker::Time.date }
    home_team_id  { build :team }
    away_team_id  { build :team }
    scorer        { build :scorer }
    season        { build :season }
  end
end