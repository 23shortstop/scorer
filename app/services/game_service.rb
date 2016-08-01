class GameService
  attr_reader :game, :inning, :half

  FULL_STRIKE_COUNT = 2
  FULL_BALL_COUNT = 3
  INITIAL_INNING_DATA = [1, 'top']
  OUTS_PER_HALF_INNING = 3
  LAST_INNING = 9
  REACHED_FIRST_EVENTS = ['single', 'safe_on_first', 'hold_first', 'walk']
  REACHED_SECOND_EVENTS = ['double', 'safe_on_second', 'hold_second']
  REACHED_THIRD_EVENTS = ['triple', 'safe_on_third', 'hold_third']

  def initialize(game)
    @game = game
    @last_pa = @game.plate_appearances.last
    set_inning
    set_team_roles
  end

  def game_state
    GameServiceSerializer.new(self).serializable_hash
  end

  def outs
    @outs ||= @last_pa ? @last_pa.outs + @last_pa.game_events.put_out.count : 0
  end

  def runners
    @runners ||= if @last_pa
      list = [@last_pa.runner_on_first, @last_pa.runner_on_second,
        @last_pa.runner_on_third, @last_pa.batter].compact

      Hash[list.map do |runner|
        last_event = @last_pa.game_events.where(player: runner).last
        case last_event.outcome
        when *REACHED_FIRST_EVENTS then [:runner_on_first, runner]
        when *REACHED_SECOND_EVENTS then [:runner_on_second, runner]
        when *REACHED_THIRD_EVENTS then [:runner_on_third, runner]
        end
      end]
    else
      {}
    end
  end

  def guests_score () @game.runs.guests.count end

  def hosts_score () @game.runs.hosts.count end

  private

  def set_inning
    @inning, @half = @last_pa ? [@last_pa.inning, @last_pa.half_inning] : INITIAL_INNING_DATA
  end

  def set_team_roles
    @ofenders, @defenders = case @half
    when 'top'    then [@game.guests, @game.hosts]
    when 'bottom' then [@game.hosts, @game.guests]
    end
  end

  def half_inning_ended?
    outs >= OUTS_PER_HALF_INNING
  end

  def game_ended?
    @inning >= LAST_INNING && case
    when @half == 'top'    && half_inning_ended? then hosts_score  > guests_score
    when @half == 'bottom' && half_inning_ended? then guests_score > hosts_score
    when @half == 'bottom'                       then hosts_score  > guests_score
    end
  end
end
