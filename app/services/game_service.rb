class GameService
  def initialize(game)
    @game = game
    @last_pa = @game.plate_appearances.last
    set_inning
    set_team_roles
  end

  private

  def set_inning
    @inning, @half = case 
    when !@last_pa then [1, 'top']
    else [@last_pa.inning, @last_pa.half_inning]
    end
  end

  def set_team_roles
    @ofenders, @defenders = case @half
    when 'top' then [@game.guests, @game.hosts]
    else [@game.hosts, @game.guests]
    end
  end
end
