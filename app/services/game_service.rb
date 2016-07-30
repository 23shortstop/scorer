class GameService
  def initialize(game)
    @game = game
    @last_pa = @game.plate_appearances.last
    set_inning
    set_team_roles
  end

  private

  INITIAL_INNING_DATA = [1, 'top']

  def set_inning
    @inning, @half = @last_pa ? [@last_pa.inning, @last_pa.half_inning] : INITIAL_INNING_DATA
  end

  def set_team_roles
    @ofenders, @defenders = case @half
    when 'top'    then [@game.guests, @game.hosts]
    when 'bottom' then [@game.hosts, @game.guests]
    end
  end

  def outs
    @outs ||= @last_pa ? @last_pa.outs + @last_pa.game_events.put_out.count : 0
  end

  OUTS_PER_HALF_INNING = 3

  def half_inning_ended?
    outs >= OUTS_PER_HALF_INNING
  end

  LAST_INNING = 9

  def game_ended?
    @inning >= LAST_INNING && case
    when @half == 'top'    && half_inning_ended? then hosts_score  > guests_score
    when @half == 'bottom' && half_inning_ended? then guests_score > hosts_score
    when @half == 'bottom'                       then hosts_score  > guests_score
    end
  end

  def guests_score () @game.runs.guests.count end

  def hosts_score () @game.runs.hosts.count end
end
