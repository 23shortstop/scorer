FactoryGirl.define do
  factory :pitch do
    outcome           { rand(0...Pitch.outcomes.size) }
    plate_appearance  { build :plate_appearance }
  end
end
