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

  has_many :runs, -> {
    where(game_events: {
        outcome: [GameEvent.outcomes[:scored], GameEvent.outcomes[:home_run]]
      })
    }, through: :plate_appearances, source: :game_events do
      def hosts
        where('plate_appearances.half_inning': PlateAppearance.half_innings[:bottom])
      end
      def guests
        where('plate_appearances.half_inning': PlateAppearance.half_innings[:top])
      end
    end
end
