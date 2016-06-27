class Session
  include ActiveModel::Serialization

  attr_reader :user, :token

  def initialize(user, token)
    @user  = user
    @token = token
  end
end
