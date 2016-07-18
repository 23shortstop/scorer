class ChangeGameAssociations < ActiveRecord::Migration
  def change
    remove_column :games, :home_team_id, :integer
    remove_column :games, :away_team_id, :integer

    add_reference :games, :hosts, index: true
    add_reference :games, :guests, index: true
  end
end
