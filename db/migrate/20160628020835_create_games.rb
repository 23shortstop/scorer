class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :home_team, index: true
      t.belongs_to :away_team, index: true
      t.belongs_to :season, index: true
      t.belongs_to :scorer, index: true
      t.datetime :date
    end

    add_foreign_key :games, :teams, column: :home_team_id
    add_foreign_key :games, :teams, column: :away_team_id
  end
end
