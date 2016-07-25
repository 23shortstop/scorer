require_relative "game_event_service"

class PitchService < GameService
  def create(outcome)
    build_new(outcome)
    create_event(outcome)
    @last_pa.save!
  end

  private

  def build_new(outcome)
    @last_pa.pitches.build(outcome: outcome)
  end

  def create_event(outcome)
    case outcome
    when 'ball' then create_game_event(:walk) if ball_count_full?
    when 'strike' then create_strike_out if strike_count_full?
    when 'hit_by_pitch' then create_game_event(:walk)
    end
  end

  FULL_BALL_COUNT = 3
  FULL_STRIKE_COUNT = 2

  def ball_count_full?
    @last_pa.pitches.ball.count == FULL_BALL_COUNT
  end

  def strike_count_full?
    @last_pa.pitches.strikes.count >= FULL_STRIKE_COUNT
  end

  def create_game_event(outcome, defender_position = nil)
    service = GameEventService.new(@game)
    service.create(outcome, nil, defender_position)
  end

  CATCHER_POSITION = 2

  def create_strike_out
    create_game_event(:strike_out, CATCHER_POSITION)
  end
end
