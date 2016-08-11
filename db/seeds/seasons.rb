Season.destroy_all

all_teams = Team.all
leagues = League.all

(2013..2016).each do |year|
  league_teams = all_teams.shuffle.in_groups(leagues.size)
  league_teams.zip(leagues).each do |teams, league|
    Season.create!(league: league,
                   year: year,
                   teams: teams)
  end
end
