class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.string :name
      t.integer :place_id
      t.integer :supermarket_id

      t.timestamps null: false
    end
  end
end
