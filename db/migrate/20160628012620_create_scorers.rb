class CreateScorers < ActiveRecord::Migration
  def change
    create_table :scorers do |t|
      t.string :name
      t.string :email
      t.string :password
    end
  end
end
