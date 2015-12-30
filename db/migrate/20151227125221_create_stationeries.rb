class CreateStationeries < ActiveRecord::Migration
  def change
    create_table :stationeries do |t|
      t.string :name
      t.string :code
      t.string :stationery_type
      t.integer :in_stocks, default: 0
      t.timestamps null: false
    end
  end
end
