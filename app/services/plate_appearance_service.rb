class PlateAppearanceService < GameService
  def create_next
    return build_new(0).save! unless @last_pa
    set_outs
    return new_inning if inning_ended?

    @new_pa = build_new
    set_runners
    @new_pa.save!
  end

  private

  OUTS_PER_INNING = 3

  def set_outs
    @outs = @last_pa.outs + @last_pa.game_events.put_out.count
  end

  def inning_ended?
    @outs >= OUTS_PER_INNING
  end

  def new_inning
    switch_half_inning
    switch_teams
    @outs = 0
    build_new.save!
  end

  def switch_teams
    @last_pa = @game.plate_appearances.where(
      'half_inning': PlateAppearance.half_innings[@half]).last
    @ofenders, @defenders = @defenders, @ofenders
  end

  def switch_half_inning
    case @half
    when 'top' then @half = 'bottom'
    else @half = 'top'; @inning = @inning + 1
    end
  end

  def build_new(outs = @outs)
    @game.plate_appearances.build(
      inning: @inning, outs: outs, half_inning: @half,
      batter: get_next_batter, pitcher: @defenders.fielders.first)
  end

  REACHED_FIRST_EVENTS = ['single', 'safe_on_first', 'hold_first', 'walk']
  REACHED_SECOND_EVENTS = ['double', 'safe_on_second', 'hold_second']
  REACHED_THIRD_EVENTS = ['triple', 'safe_on_third', 'hold_third']

  def set_runners
    runners = [@last_pa.runner_on_first, @last_pa.runner_on_second,
      @last_pa.runner_on_third, @last_pa.batter].compact!

    runners.each do |runner|
      last_event = @last_pa.game_events.where(player: runner).last
      case last_event.outcome
      when *REACHED_FIRST_EVENTS then @new_pa.runner_on_first = runner
      when *REACHED_SECOND_EVENTS then @new_pa.runner_on_second = runner
      when *REACHED_THIRD_EVENTS then @new_pa.runner_on_third = runner
      end
    end
  end

  def get_next_batter
    batting_order = @ofenders.batters
    return batting_order.first unless @last_pa
    last_batter_index = batting_order.index(@last_pa.batter)

    batting_order.fetch(last_batter_index + 1, batting_order.first)
  end
end
