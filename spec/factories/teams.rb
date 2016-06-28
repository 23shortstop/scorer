FactoryGirl.define do
  factory :team do
    team_name  { Faker::Team.name }
    city       { Faker::Number.between(1900, 2100) }
    logo       { FFaker::Address.city }
    seasons    { build_list :season, 10 }
  end
end