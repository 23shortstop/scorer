class Api::V1::LineupsController < Api::V1::BaseController
  before_action :set_game

  def create
    game_state = create_lineups()
    render json: game_state
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def create_lineups
    LineupService.new(@game).create(*lineups_params)
  end

  def lineups_params
    [params.require(:hosts), params.require(:guests)]
  end
end
