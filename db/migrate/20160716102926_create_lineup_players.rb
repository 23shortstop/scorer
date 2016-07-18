class CreateLineupPlayers < ActiveRecord::Migration
  def change
    create_table :lineup_players do |t|
      t.integer :batting_position
      t.integer :fielding_position
      t.belongs_to :lineup
      t.belongs_to :player
    end
  end
end
