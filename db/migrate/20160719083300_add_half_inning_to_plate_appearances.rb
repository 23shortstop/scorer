class AddHalfInningToPlateAppearances < ActiveRecord::Migration
  def change
    add_column :plate_appearances, :half_inning, :integer
  end
end
