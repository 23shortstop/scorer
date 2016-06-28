class Team < ActiveRecord::Base
  validates :team_name, presence: true
  validates :city, presence: true

  has_and_belongs_to_many :seasons
end