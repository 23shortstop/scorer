class PlateAppearanceService < GameService
  def create_next
    start_next_half_inning if half_inning_ended?
    set_runners
    new_pa.save!
  end

  private

  def outs
    @outs ||= @last_pa ? @last_pa.outs + @last_pa.game_events.put_out.count : 0
  end

  OUTS_PER_HALF_INNING = 3

  def half_inning_ended?
    outs >= OUTS_PER_HALF_INNING
  end

  def start_next_half_inning
    switch_half_inning
    switch_teams
    @outs = 0
  end

  def switch_teams
    @last_pa = @game.plate_appearances.where(half_inning: @half.to_sym).last
    @ofenders, @defenders = @defenders, @ofenders
  end

  def switch_half_inning
    if @half == 'top'
      @half = 'bottom'
    else
      @half = 'top'
      @inning = @inning + 1
    end
  end

  def new_pa
    @new_pa ||= @game.plate_appearances.build(inning: @inning, outs: outs, half_inning: @half,
      batter: next_batter, pitcher: @defenders.fielders.first)
  end

  REACHED_FIRST_EVENTS = ['single', 'safe_on_first', 'hold_first', 'walk']
  REACHED_SECOND_EVENTS = ['double', 'safe_on_second', 'hold_second']
  REACHED_THIRD_EVENTS = ['triple', 'safe_on_third', 'hold_third']

  def set_runners
    if @last_pa
      runners = [@last_pa.runner_on_first, @last_pa.runner_on_second,
        @last_pa.runner_on_third, @last_pa.batter].compact!

      runners.each do |runner|
        last_event = @last_pa.game_events.where(player: runner).last
        case last_event.outcome
        when *REACHED_FIRST_EVENTS then new_pa.runner_on_first = runner
        when *REACHED_SECOND_EVENTS then new_pa.runner_on_second = runner
        when *REACHED_THIRD_EVENTS then new_pa.runner_on_third = runner
        end
      end
    end
  end

  def next_batter
    batting_order = @ofenders.batters
    next_batter_index = @last_pa ? batting_order.index(@last_pa.batter) + 1 : 0
    batting_order.fetch(next_batter_index, batting_order.first)
  end
end
