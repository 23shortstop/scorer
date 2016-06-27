class Season < ActiveRecord::Base
  validates :league, presence: true
  validates :year, presence: true

  belongs_to :league
end