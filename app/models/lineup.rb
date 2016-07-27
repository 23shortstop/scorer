class Lineup < ActiveRecord::Base
  validates :team, presence: true

  has_one :game, foreign_key: 'hosts_id'
  has_one :game, foreign_key: 'guests_id'
  belongs_to :team
  has_many :lineup_players
  has_many :players, through: :lineup_players

  has_many :batters, -> { order 'lineup_players.batting_position' },
  through: :lineup_players, source: :player
  
  has_many :fielders, -> { order 'lineup_players.fielding_position' },
  through: :lineup_players, source: :player do
    def get_by_position(position) where(lineup_players: { fielding_position: position }).first end
  end
end
