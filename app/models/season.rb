class Season < ActiveRecord::Base
  validates :league, presence: true
  validates :year, presence: true

  belongs_to :league
  has_and_belongs_to_many :teams
  has_many :games
end