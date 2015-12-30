class CreateUserStationeries < ActiveRecord::Migration
  def change
    create_table :user_stationeries do |t|
      t.references :user, index: true, foreign_key: true
      t.references :stationery, index: true, foreign_key: true
      t.string :status, default: 'BORROWED'
      t.datetime :overdue_at
      t.timestamps null: false
    end
  end
end
