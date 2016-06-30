class TeamSerializer < ActiveModel::Serializer
  attributes :team_name, :city, :logo

  def logo
    object.logo.url
  end
end
