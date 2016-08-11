class Api::V1::GamesController < Api::V1::BaseController
  before_action :set_game, only: [:show]

  def index
    render json: Game.all
  end

  def show
    render json: @game
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
