class Api::V1::TeamsController < Api::V1::BaseController
  def index
    render json: Team.all
  end

  def show
    team = Team.find(params[:id])
    render json: team
  end
end
