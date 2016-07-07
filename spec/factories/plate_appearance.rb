FactoryGirl.define do
  factory :plate_appearance do
    game    { build :game }
    batter  { build :player }
    pitcher { build :player }
    inning  { rand(1..9) }
    outs    { rand(0..2) }
  end
end
