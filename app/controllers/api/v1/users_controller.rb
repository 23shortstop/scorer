class Api::V1::UsersController < Api::V1::BaseController
  acts_as_token_authenticator_for User, only: [:current]

  def create
    @user = User.create!(user_params)
    render json: @user
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def current
    render json: current_user
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
