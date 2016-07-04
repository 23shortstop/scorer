FactoryGirl.define do
  factory :team do
    team_name  { FFaker::Company.name }
    city       { FFaker::Address.city }
    logo       { FFaker::Avatar.image }
  end
end
