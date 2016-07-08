class CreatePlateAppearances < ActiveRecord::Migration
  def change
    create_table :plate_appearances do |t|
      t.belongs_to :game, index: true
      t.integer :inning
      t.integer :outs
      t.belongs_to :batter, index: true
      t.belongs_to :pitcher, index: true
      t.belongs_to :runner_on_first, index: true
      t.belongs_to :runner_on_second, index: true
      t.belongs_to :runner_on_third, index: true
    end

    add_foreign_key :plate_appearances, :players, column: :batter_id
    add_foreign_key :plate_appearances, :players, column: :pitcher_id
    add_foreign_key :plate_appearances, :players, column: :runner_on_first_id
    add_foreign_key :plate_appearances, :players, column: :runner_on_second_id
    add_foreign_key :plate_appearances, :players, column: :runner_on_third_id
  end
end
