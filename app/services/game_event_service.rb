class GameEventService < GameService
  OUT_EVENTS = [:sacrifice_fly, :sacrifice_bunt, :strike_out, :force_out, :tag_out, :fly_out]
  BATTER_BASE = nil

  def create(*params)
    create_list(params)
    @last_pa.save!
    change_game_state(params)
    game_state
  end

  private

  def create_list(params)
    params.each do |param|
      create_particular(param[:outcome], param[:offender_base], param[:defender_position],
        param[:assistant_position])
    end
  end

  def create_particular(outcome, offender_base, defender_position, assistant_position)
    build_game_event(outcome, offenders(offender_base))
    if out_event?(outcome)
      build_out_event(defenders(defender_position), defenders(assistant_position))
    end
  end

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
    when BATTER_BASE then @last_pa.batter
    when 1           then @last_pa.runner_on_first
    when 2           then @last_pa.runner_on_first
    when 3           then @last_pa.runner_on_third
    end
  end

  def change_game_state(params)
    case
    when game_ended?       then @game.ended!
    when pa_ended?(params) then create_next_pa
    end
  end

  def create_next_pa
    service = PlateAppearanceService.new(@game)
    service.create_next
  end

  def pa_ended?(params)
    (params.map { |p| p[:offender_base] }).include?(BATTER_BASE)
  end
end
