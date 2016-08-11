FactoryGirl.define do
  factory :game_event do
    outcome           { rand(0...GameEvent.outcomes.size) }
    plate_appearance  { build :plate_appearance }
    player            { build :player }
  end
end
