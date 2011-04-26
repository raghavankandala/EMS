class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.string :venue
      t.text :schedule
      t.text :contact
      t.string :city
      t.integer :etype
      t.string :facebook_url
      t.string :twitter_url
      t.string :orkut_url
      t.string :venue_directions_url
      t.string :venue_content_type
      t.string :venue_file_name
      t.integer :venue_file_size
      t.string :rallyroute_content_type
      t.string :rallyroute_file_name
      t.integer :rallyroute_file_size
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
