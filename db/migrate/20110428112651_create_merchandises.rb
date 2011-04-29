class CreateMerchandises < ActiveRecord::Migration
  def self.up
    create_table :merchandises do |t|
      t.string :title
      t.string :cover_image_file_name
      t.string :cover_image_content_type
      t.integer :cover_image_file_size
      t.string :material_file_name
      t.string :material_content_type
      t.integer :material_file_size
      t.integer :event_id
      t.timestamps
    end
  end

  def self.down
    drop_table :merchandises
  end
end
