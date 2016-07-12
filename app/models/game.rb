class Game < ActiveRecord::Base
  validates :home_team, presence: true
  validates :away_team, presence: true
  validates :scorer, presence: true
  validates :season, presence: true
  validates :date, presence: true

  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'
  belongs_to :scorer
  belongs_to :season
  has_many :plate_appearances

  # A temporary lineups stub for the game
  after_create :set_lineup

  attr_reader :home_team_lineup,  :away_team_lineup,
              :home_team_pitcher, :away_team_pitcher

  private

  def set_lineup
    @home_team_lineup = self.home_team.players.sample(9)
    @away_team_lineup = self.away_team.players.sample(9)

    @home_team_pitcher = @home_team_lineup.sample
    @away_team_pitcher = @away_team_lineup.sample
  end
  # A temporary lineups stub for the game

  # TODO replase the stub with the real implementation of lineups
end
