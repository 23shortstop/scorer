class Lineup < ActiveRecord::Base
  validates :team, presence: true

  has_one :game, foreign_key: 'hosts_id'
  has_one :game, foreign_key: 'guests_id'
  belongs_to :team
  has_many :lineup_players
  has_many :players, through: :lineup_players
end
