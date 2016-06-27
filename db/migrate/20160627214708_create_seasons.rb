class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.belongs_to :league, index: true
      t.integer :year
    end
  end
end
