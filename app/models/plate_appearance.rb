class PlateAppearance < ActiveRecord::Base
  validates :game, presence: true
  validates :batter, presence: true
  validates :pitcher, presence: true
  validates :inning, presence: true
  validates :outs, presence: true

  belongs_to :game
  belongs_to :batter,           class_name: 'Player', foreign_key: 'batter_id'
  belongs_to :pitcher,          class_name: 'Player', foreign_key: 'pitcher_id'
  belongs_to :runner_on_first,  class_name: 'Player', foreign_key: 'runner_on_first_id'
  belongs_to :runner_on_second, class_name: 'Player', foreign_key: 'runner_on_second_id'
  belongs_to :runner_on_third,  class_name: 'Player', foreign_key: 'runner_on_third_id'
  has_many :pitches
  has_many :game_events

  has_one :offense_team, class_name: 'Team', through: :batter, source: 'team'
  has_one :defense_team, class_name: 'Team', through: :pitcher, source: 'team'
end
