class Pitch < ActiveRecord::Base
  validates :outcome, presence: true
  validates :plate_appearance, presence: true

  enum outcome: [:ball, :strike, :foul, :fair, :hit_by_pitch]

  belongs_to :plate_appearance

  scope :strikes, -> {
    where(outcome: [outcomes[:strike], outcomes[:foul]]) }
end
