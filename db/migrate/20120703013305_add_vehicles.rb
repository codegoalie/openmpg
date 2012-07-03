class AddVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.integer :user_id, :null => false
      t.string  :nickname, :null => false
      t.integer :year
      t.string  :make
      t.string  :model
      t.string  :color
    end
  end
end
