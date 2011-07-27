class CreateAlerts < ActiveRecord::Migration
  def self.up
    create_table :alerts do |t|
      t.text :content
      t.datetime :validity
      t.timestamps
    end
  end

  def self.down
    drop_table :alerts
  end
end
