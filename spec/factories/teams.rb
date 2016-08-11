FactoryGirl.define do
  factory :team do
    team_name  { FFaker::Company.name }
    city       { FFaker::Address.city }
    logo       { FFaker::Avatar.image }

    after(:build) do |team|
      team.players << build_list(:player, 20, team: team)
    end
  end
end
