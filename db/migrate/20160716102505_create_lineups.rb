class CreateLineups < ActiveRecord::Migration
  def change
    create_table :lineups do |t|
      t.belongs_to :team, index: true
    end
  end
end
