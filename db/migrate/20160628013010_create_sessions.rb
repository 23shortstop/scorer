class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :authenticable, polymorphic: true, index: true
      t.string :token
      t.timestamps null: false
    end
  end
end
