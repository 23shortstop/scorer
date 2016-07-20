class PlateAppearanceService
  def initialize(game)
    @game = game
    @last_pa = @game.plate_appearances.last
  end

  def create_next
    return build_new_inning(1, 'top').save! unless @last_pa
    return build_new_inning(*get_next_half_inning).save! if inning_ended?

    @new_pa = build_new(@outs)
    set_runners
    @new_pa.save!
  end

  private

  def inning_ended?
    outs_per_inning = 3
    @outs = @last_pa.outs + @last_pa.game_events.put_out.count
    @outs >= outs_per_inning
  end

  def build_new(outs, inning = @last_pa.inning, half = @last_pa.half_inning, last_batter = @last_pa.batter)
    @game.plate_appearances.build(
      inning: inning, outs: outs, half_inning: half,
      batter: get_next_batter(last_batter, half),
      pitcher: get_pitcher(half))
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

  def get_next_batter(last_batter, half)
    offenders = get_offenders(half)
    batting_order = offenders.batters

    get_next_or_first(batting_order, last_batter)
  end

  def get_offenders(half)
    half == 'top' ? @game.guests : @game.hosts
  end

  def get_next_or_first(order, last)
    last_index = last ? order.index(last) : -1
    next_index = (last_index + 1) % order.size

    order[next_index]
  end

  def get_pitcher(half)
    defenders = get_defenders(half)
    defenders.fielders.first
  end

  def get_defenders(half)
    half == 'top' ? @game.hosts : @game.guests
  end

  def get_next_half_inning
    case @last_pa.half_inning
    when 'top' then [@last_pa.inning, :bottom]
    when 'bottom' then [@last_pa.inning + 1, :top]
    end
  end

  def build_new_inning(inning, half)
    last_team_pa = @game.plate_appearances.where('half_inning': half).last
    last_batter = last_team_pa ? last_team_pa.batter : nil

    build_new(0, inning, half, last_batter)
  end
end
