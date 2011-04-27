class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.string :name
      t.string :mobile
      t.string :email
      t.text :address
      t.integer :locality_id
      t.integer :ward_id
      t.boolean :confirmed
      t.string :guid
      t.boolean :student
      t.string :institution
      t.string :volunteering_area
      t.text :volunteer_description
      t.integer :rtype
      t.timestamp :confirmed_at
      t.timestamps
    end
  end

  def self.down
    drop_table :registrations
  end
end
