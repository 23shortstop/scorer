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
end
