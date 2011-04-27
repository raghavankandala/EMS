class CreateEventRegistrations < ActiveRecord::Migration
  def self.up
    create_table :event_registrations do |t|
      t.integer :event_id
      t.integer :registration_id
      t.integer :rtype
      t.string :guid
      t.boolean :confirmed
      t.timestamp :confirmed_at
      t.timestamps
    end
  end

  def self.down
    drop_table :event_registrations
  end
end
