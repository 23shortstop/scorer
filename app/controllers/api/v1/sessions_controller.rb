class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user, token = User.authenticate(*auth_params)
    render json: Session.new(user, token)
  end

  def auth_params
    [params.require(:email), params.require(:password)]
  end
end
