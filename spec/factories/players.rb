FactoryGirl.define do
  factory :player do
    name   { FFaker::Name.name }
    number { rand(0..99) }
    team   { build :team }
  end
end
