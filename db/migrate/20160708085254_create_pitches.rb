class CreatePitches < ActiveRecord::Migration
  def change
    create_table :pitches do |t|
      t.integer :outcome
      t.belongs_to :plate_appearance
    end
  end
end
