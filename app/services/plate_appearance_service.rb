class PlateAppearanceService
  def initialize(game)
    @game = game
  end

  def create_next_pa
    @last_pa = @game.plate_appearances.last
    return create_new_inning_pa(1, 'top').save! unless @last_pa

    outs = @last_pa.outs + @last_pa.game_events.put_out.count
    return create_new_inning_pa(*get_next_inning_data).save! if outs >= 3

    @new_pa = @game.plate_appearances.build(
      inning: @last_pa.inning, outs: outs, half_inning: @last_pa.half_inning,
      batter: get_next_batter(@last_pa.batter, @last_pa.half_inning),
      pitcher: get_pitcher(@last_pa.half_inning))

    set_runners
    @new_pa.save!
  end

  private

  def set_runners
    runners = [@last_pa.runner_on_first, @last_pa.runner_on_second,
      @last_pa.runner_on_third, @last_pa.batter].compact!

    runners.each do |runner|
      last_event = @last_pa.game_events.where(player: runner).last
      case last_event.outcome
      when *['single', 'safe_on_first', 'hold_first', 'walk']
        @new_pa.runner_on_first = runner
      when *['double', 'safe_on_second', 'hold_second']
        @new_pa.runner_on_second = runner
      when *['triple', 'safe_on_third', 'hold_third']
        @new_pa.runner_on_third = runner
      end
    end
  end

  def get_next_batter(last_batter, half)
    lineup_id = half == 'top' ? @game.guests.id : @game.hosts.id

    batting_order = Player.joins(:lineups, :lineup_players)
    .where('lineups.id': lineup_id)
    .order("lineup_players.batting_position")

    last_index = last_batter ? batting_order.index(last_batter) : -1
    next_index = (last_index + 1) % 9

    batting_order[next_index]
  end

  def get_pitcher(half)
    lineup_id = half == 'top' ? @game.hosts.id : @game.guests.id

    Player.joins(:lineups, :lineup_players)
    .where('lineups.id': lineup_id)
    .order("lineup_players.fielding_position").first
  end

  def get_next_inning_data
    inning, half = case @last_pa.half_inning
    when 'top' then [@last_pa.inning, :bottom]
    when 'bottom' then [(@last_pa.inning + 1), :top]
    end
  end

  def create_new_inning_pa(inning, half)
    last_team_pa = @game.plate_appearances.where('half_inning': half).last
    last_batter = last_team_pa ? last_team_pa.batter : nil

    @game.plate_appearances.build(
      inning: inning, half_inning: half, outs: 0,
      batter: get_next_batter(last_batter, half),
      pitcher: get_pitcher(half))
  end
end
