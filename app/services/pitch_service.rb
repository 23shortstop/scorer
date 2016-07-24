class PitchService < GameService
  def create(outcome)
    build_new(outcome)
  end

  private

  def build_new(outcome)
    @last_pa.pitches.events.build(outcome: outcome)
  end

  def check_count_or_save(outcome)
    case outcome
    when 'ball' then check_walk
    when 'strike' then check_strike
    when 'hit_by_pitch' then create_walk
    else @last_pa.save!
    end
  end

  def ball_count_full?
    full_ball_count = 3
    @last_pa.pitches.balls.count = full_ball_count
  end

  def strike_count_full?
    full_strike_count = 2
    @last_pa.pitches.strikes.count >= full_ball_count
  end

  def create_game_event(*args)
    service = GameEventService(@game)
    service.create(args)
  end

  def create_strike_out
    create_game_event(:strike_out, @last_pa.batter)
  end
end
