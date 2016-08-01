class GameServiceSerializer < ActiveModel::Serializer
  def attributes(*args)
    if object.game.in_progress? then game_data.merge(game_progress) else game_data end
  end

  def game_data
    { game: object.game.id,
      date: object.game.date,
      status: object.game.status,
      hosts: object.game.hosts.team.team_name,
      guests: object.game.guests.team.team_name,
      hosts_score: object.hosts_score,
      guests_score: object.guests_score }
  end

  def game_progress
    plate_appearance = object.game.plate_appearances.last
    { inning: object.inning,
      half_inning: object.half,
      outs: object.outs,
      pitcher: plate_appearance.pitcher.name,
      pitches: plate_appearance.pitcher.pitches.in_game(object.game).count,
      batter: plate_appearance.batter.name,
      balls: plate_appearance.pitches.balls.count,
      strikes: [GameService::FULL_STRIKE_COUNT, plate_appearance.pitches.strikes.count].min,
      runner_on_first: object.runners[:runner_on_first],
      runner_on_second: object.runners[:runner_on_second],
      runner_on_third: object.runners[:runner_on_third] }
  end
end
