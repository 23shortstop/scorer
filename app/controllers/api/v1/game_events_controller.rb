class Api::V1::GameEventsController < Api::V1::BaseController
  before_action :set_game

  def create
    game_state = create_game_event
    render json: game_state
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def create_game_event
    GameEventService.new(@game).create(*game_event_params)
  end

  def game_event_params
    params.require(:game_events)
  end
end
