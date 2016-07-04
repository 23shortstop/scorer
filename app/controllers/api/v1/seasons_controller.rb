class Api::V1::SeasonsController < Api::V1::BaseController
  def index
    render json: Season.all
  end

  def show
    season = Season.find(params[:id])
    render json: season
  end
end
