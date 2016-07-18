class Player < ActiveRecord::Base
  validates :name, presence: true
  validates :number, presence: true
  validates :number, inclusion: { in: 0..99 }

  mount_uploader :photo, ImageUploader

  belongs_to :team
  has_many :game_events
  has_many :lineup_players
  has_many :lineups, through: :lineup_players
end
