class LineupPlayer < ActiveRecord::Base
  validates :batting_position, presence: true
  validates :fielding_position, presence: true
  validates :player, presence: true
  validates :lineup, presence: true
  validates :batting_position, inclusion: { in: 1..9 }
  validates :fielding_position, inclusion: { in: 1..9 }
  validates :batting_position, uniqueness: { scope: :lineup_id }
  validates :fielding_position, uniqueness: { scope: :lineup_id }

  belongs_to :player
  belongs_to :lineup
end
