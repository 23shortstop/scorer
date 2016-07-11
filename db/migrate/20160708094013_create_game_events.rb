class CreateGameEvents < ActiveRecord::Migration
  def change
    create_table :game_events do |t|
      t.integer :outcome
      t.belongs_to :plate_appearance
      t.belongs_to :player
    end
  end
end
