class Api::V1::SeasonsController < Api::V1::BaseController
  before_action :set_season, only: [:show]

  def index
    render json: Season.all
  end

  def show
    render json: @season
  end

  private

  def set_season
    @season = Season.find(params[:id])
  end
end
