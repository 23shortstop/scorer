class GameEventService < GameService
  def create(outcome, offender_base,
    defender_position = nil, assistant_position = nil)
    build(outcome, get_offender(offender_base))
    if out?(outcome)
      build_out(get_defender(defender_position),
        get_defender(assistant_position))
    end
    @last_pa.save!
  end

  private

  OUT_EVENTS = [:sacrifice_fly, :sacrifice_bunt,
                :force_out, :tag_out, :fly_out]

  def out?(outcome)
    OUT_EVENTS.include? outcome
  end

  def build(outcome, player)
    @last_pa.game_events.build(outcome: outcome, player: player)
  end

  def build_out(defender, assistant = nil)
    build('put_out', defender)
    build_assist(assistant) if assistant
  end

  def build_assist(assistant)
    build('assist', assistant)
  end

  def get_defender(defender_position)
    @defenders.fielders.get_by_position(defender_position)
  end

  def get_offender(offender_base = nil)
    case offender_base
    when nil then @last_pa.batter
    when 1 then @last_pa.runner_on_first
    when 2 then @last_pa.runner_on_first
    when 3 then @last_pa.runner_on_third
    end
  end
end
