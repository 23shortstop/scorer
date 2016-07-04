class GameSerializer < ActiveModel::Serializer
  attributes :home_team, :away_team, :date

  def home_team
    object.home_team.team_name
  end

  def away_team
    object.away_team.team_name
  end

  def date
    object.date.strftime("%F %T")
  end
end
