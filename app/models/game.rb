class Game < ActiveRecord::Base
  validates :home_team_id, presence: true
  validates :away_team_id, presence: true
  validates :scorer, presence: true
  validates :season, presence: true
  validates :date, presence: true

  belongs_to :home_team, :class_name => 'Team', :foreign_key => 'home_team_id'
  belongs_to :away_team, :class_name => 'Team', :foreign_key => 'away_team_id'
  belongs_to :scorer
  belongs_to :season
end