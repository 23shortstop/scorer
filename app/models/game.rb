class Game < ActiveRecord::Base
  validates :hosts, presence: true
  validates :guests, presence: true
  validates :scorer, presence: true
  validates :season, presence: true
  validates :date, presence: true

  enum status: [:not_started, :in_progress, :ended]

  belongs_to :hosts, class_name: 'Lineup', foreign_key: 'hosts_id'
  belongs_to :guests, class_name: 'Lineup', foreign_key: 'guests_id'

  belongs_to :scorer
  belongs_to :season
  has_many :plate_appearances
end
