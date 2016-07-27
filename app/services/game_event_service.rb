class GameEventService < GameService
  def create(outcome, offender_base = nil, defender_position = nil, assistant_position = nil)
    build_game_event(outcome, offenders(offender_base))
    if out_event?(outcome)
      build_out_event(defenders(defender_position), defenders(assistant_position))
    end
    @last_pa.save!
  end

  private

  OUT_EVENTS = [:sacrifice_fly, :sacrifice_bunt, :strike_out, :force_out, :tag_out, :fly_out]

  def out_event?(outcome)
    OUT_EVENTS.include? outcome
  end

  def build_game_event(outcome, player)
    @last_pa.game_events.build(outcome: outcome, player: player)
  end

  def build_out_event(defender, assistant)
    build_game_event('put_out', defender)
    build_assist_event(assistant) if assistant
  end

  def build_assist_event(assistant)
    build_game_event('assist', assistant)
  end

  def defenders(defender_position)
    @defenders.fielders.get_by_position(defender_position)
  end

  def offenders(offender_base)
    case offender_base
    when nil then @last_pa.batter
    when 1 then @last_pa.runner_on_first
    when 2 then @last_pa.runner_on_first
    when 3 then @last_pa.runner_on_third
    end
  end
end
