class GameSerializer < ActiveModel::Serializer
  attributes :home_team, :away_team, :date

  def home_team
    object.hosts.team.team_name
  end

  def away_team
    object.guests.team.team_name
  end

  def date
    object.date.strftime("%F %T")
  end
end
