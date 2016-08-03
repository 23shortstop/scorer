class GameServiceSerializer < ActiveModel::Serializer
  def attributes(*args)
    {
      game_data: game_data,
      game_progress: object.game.in_progress? ? game_progress : nil
    }
  end

  def game_data
    {
      game: object.game.id,
      date: object.game.date,
      status: object.game.status,
      hosts: object.game.hosts.team.team_name,
      guests: object.game.guests.team.team_name,
      hosts_score: object.hosts_score,
      guests_score: object.guests_score
    }
  end

  def game_progress
    plate_appearance = object.game.plate_appearances.last
    {
      inning: plate_appearance.inning,
      half_inning: plate_appearance.half_inning,
      outs: object.outs,
      pitcher: plate_appearance.pitcher.name,
      pitches: plate_appearance.pitcher.pitches.in_game(object.game).count,
      batter: plate_appearance.batter.name,
      balls: plate_appearance.pitches.balls.count,
      strikes: [GameService::FULL_STRIKE_COUNT, plate_appearance.pitches.strikes.count].min,
      runner_on_first: object.runners_on_bases[:runner_on_first].try(:name),
      runner_on_second: object.runners_on_bases[:runner_on_second].try(:name),
      runner_on_third: object.runners_on_bases[:runner_on_third].try(:name)
    }
  end
end
