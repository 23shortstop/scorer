FactoryGirl.define do
  factory :lineup_player do
    batting_position  { rand(1..9) }
    fielding_position { rand(1..9) }
    lineup            { build :lineup }
    player            { build :player }
  end
end
