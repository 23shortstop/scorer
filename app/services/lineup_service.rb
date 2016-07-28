class LineupService < GameService
  def create(hosts, guests)
    fill_lineup(@game.hosts, hosts)
    fill_lineup(@game.guests, guests)
    start_game
    @game.save!
  end

  private

  def fill_lineup(lineup, players)
    players.each { |player| lineup.lineup_players.build(batting_position: player[:batting_position],
      fielding_position: player[:fielding_position], player_id: player[:player_id]) }
    lineup.save!
  end

  def start_game
    @game.status = :in_progress
    PlateAppearanceService.new(@game).create_next
  end
end
