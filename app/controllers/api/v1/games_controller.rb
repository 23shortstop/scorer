class Api::V1::GamesController < Api::V1::BaseController
  def index
    render json: Game.all
  end

  def show
    game = Game.find(params[:id])
    render json: game
  end
end
