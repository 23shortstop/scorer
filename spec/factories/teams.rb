FactoryGirl.define do
  factory :team do
    team_name  { Faker::Team.name }
    city       { Faker::Address.city }
    logo       { Faker::Avatar.image }
    seasons    { build_list :season, 10 }
  end
end