class League < ActiveRecord::Base
  validates :league_name, presence: true

  has_many :seasons
end
