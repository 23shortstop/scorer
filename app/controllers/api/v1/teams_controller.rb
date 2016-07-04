class Api::V1::TeamsController < Api::V1::BaseController
  before_action :set_team, only: [:show]

  def index
    render json: Team.all
  end

  def show
    render json: @team
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end
end
