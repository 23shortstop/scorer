class SeasonSerializer < ActiveModel::Serializer
  attributes :league, :year

  def league
    object.league.league_name
  end
end
