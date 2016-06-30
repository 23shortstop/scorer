Player.destroy_all

Team.find_each do |team|
  20.times do |i|
    player = Player.new(team: team,
                        name: FFaker::Name.name,
                        number: i)
    player.remote_photo_url = FFaker::Avatar.image
    player.save!
  end
end
