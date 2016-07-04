Team.destroy_all

8.times do |i|
  team = Team.new(team_name: "Team_#{i}",
               city: FFaker::Address.city)
  team.remote_logo_url = FFaker::Avatar.image
  team.save!
end
