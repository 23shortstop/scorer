class Team < ActiveRecord::Base
  validates :team_name, presence: true
  validates :city, presence: true

  has_and_belongs_to_many :seasons
  has_many :players

  has_many :home_games, class_name: 'Game', foreign_key: 'home_team_id'
  has_many :away_games, class_name: 'Game', foreign_key: 'away_team_id'

  def games
    Game.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)
  end
end