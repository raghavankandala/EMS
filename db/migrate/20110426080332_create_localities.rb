class CreateLocalities < ActiveRecord::Migration
  def self.up
    create_table :localities do |t|
      t.string :name
      t.column :lat, "double precision"
      t.column :lon, "double precision"
      t.timestamps
    end
  end

  def self.down
    drop_table :localities
  end
end
