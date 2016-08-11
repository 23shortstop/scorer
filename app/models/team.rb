class Team < ActiveRecord::Base
  validates :team_name, presence: true
  validates :city, presence: true

  mount_uploader :logo, ImageUploader

  has_and_belongs_to_many :seasons
  has_many :players

  has_many :lineups
  has_many :games, through: :lineups
end
