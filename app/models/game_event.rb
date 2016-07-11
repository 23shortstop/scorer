class GameEvent < ActiveRecord::Base
  validates :outcome, presence: true
  validates :plate_appearance, presence: true
  validates :player, presence: true

  enum outcome: [
    :assist, :put_out,
    :single, :double, :triple, :home_run,
    :safe_on_first, :safe_on_second, :safe_on_third, :scored,
    :walk,
    :sacrifice_fly, :sacrifice_bunt,
    :force_out, :tag_out, :fly_out, :fielders_choice
  ]

  belongs_to :plate_appearance
  belongs_to :player
end
