class CreateFillups < ActiveRecord::Migration
  def up
    create_table :fillups do |t|
      t.integer   :mileage
      t.integer   :vehicle_id
      t.float     :gallons
      t.float     :ppg
      t.float     :mpg
      t.timestamp :filled_at
    end
  end

  def down
    drop_table :fillups
  end
end
