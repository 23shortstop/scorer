FactoryGirl.define do
  factory :pitch do
    outcome { rand(0..4) }
    plate_appearance { build :plate_appearance }
  end
end
