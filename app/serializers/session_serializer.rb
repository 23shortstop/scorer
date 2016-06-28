class SessionSerializer < ActiveModel::Serializer
  attributes :authenticable, :token

  self.root = false

  def token
    object.token
  end
end
