FactoryGirl.define do
  factory :team do
    team_name  { Faker::Team.name }
    city       { Faker::Address.city }
    logo       { Faker::Avatar.image }
  end
end