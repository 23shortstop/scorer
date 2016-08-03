class Player < ActiveRecord::Base
  validates :name, presence: true
  validates :number, presence: true
  validates :number, inclusion: { in: 0..99 }

  mount_uploader :photo, ImageUploader

  belongs_to :team
  has_many :game_events
  has_many :plate_appearances_as_pitcher, class_name: 'PlateAppearance', foreign_key: 'pitcher_id'
  has_many :lineup_players
  has_many :lineups, through: :lineup_players

  has_many :pitches, through: :plate_appearances_as_pitcher do
    def in_game(game)
      where('plate_appearances.game_id': game.id)
    end
  end
end
