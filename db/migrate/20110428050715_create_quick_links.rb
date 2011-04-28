class CreateQuickLinks < ActiveRecord::Migration
  def self.up
    create_table :quick_links do |t|
      t.string :title
      t.boolean :external
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.string :external_link
      t.timestamps
    end
  end

  def self.down
    drop_table :quick_links
  end
end
