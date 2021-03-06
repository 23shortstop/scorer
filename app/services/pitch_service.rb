require_relative "game_event_service"

class PitchService < GameService
  CATCHER_POSITION = 2

  def create(outcome)
    build_new_pitch(outcome)
    create_event(outcome)
    @last_pa.save!
  end

  private

  def build_new_pitch(outcome)
    @last_pa.pitches.build(outcome: outcome)
  end

  def create_event(outcome)
    case outcome
    when 'ball'         then create_game_event(:walk) if ball_count_full?
    when 'strike'       then create_strike_out if strike_count_full?
    when 'hit_by_pitch' then create_game_event(:walk)
    end
  end

  def ball_count_full?
    @last_pa.pitches.ball.count == FULL_BALL_COUNT
  end

  def strike_count_full?
    @last_pa.pitches.strikes.count >= FULL_STRIKE_COUNT
  end

  def create_game_event(outcome, defender_position = nil)
    service = GameEventService.new(@game)
    service.create({ outcome: outcome, defender_position: defender_position })
  end

  def create_strike_out
    create_game_event(:strike_out, CATCHER_POSITION)
  end
end
