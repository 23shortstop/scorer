class SessionSerializer < ActiveModel::Serializer
  attributes :user, :token

  self.root = false

  def user
    UserSerializer.new(object.user, { root: false })
  end

  def token
    object.token
  end
end
