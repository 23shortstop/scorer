Game.destroy_all

Season.find_each do |season|
  season.teams.permutation(2) do |home_team, away_team|
    Game.create(home_team: home_team,
                away_team: away_team,
                season: season,
                scorer: Scorer.first!,
                date: FFaker::Time.date(year: season.year))
  end
end