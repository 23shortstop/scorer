class GameService
  def initialize(game)
    @game = game
    @last_pa = @game.plate_appearances.last
  end
end
