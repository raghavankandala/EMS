class CreateWards < ActiveRecord::Migration
  def self.up
    create_table :wards do |t|
      t.string :name
      t.integer :ward_no
      t.integer :total_population
      t.column :area, "numeric"
      t.column :lat, "double precision"
      t.column :lon, "double precision"
      t.timestamps
    end
  end

  def self.down
    drop_table :wards
  end
end
