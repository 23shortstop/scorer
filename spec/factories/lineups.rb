FactoryGirl.define do
  factory :lineup do
    team { build :team }
  end
end
