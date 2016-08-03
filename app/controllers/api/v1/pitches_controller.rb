class Api::V1::PitchesController < Api::V1::BaseController
  before_action :set_game

  def create
    game_state = create_pitch
    render json: game_state
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def create_pitch
    service = PitchService.new(@game)
    service.create(pitch_params)
    service.game_state
  end

  def pitch_params
    params.require(:outcome)
  end
end
