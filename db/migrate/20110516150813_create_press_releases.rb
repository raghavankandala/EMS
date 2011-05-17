class CreatePressReleases < ActiveRecord::Migration
  def self.up
    create_table :press_releases do |t|
      t.string :title
      t.text :content
      t.date :pr_date
      t.boolean :external, :default => false
      t.string :url
      t.string :source
      t.timestamps
    end
  end

  def self.down
    drop_table :press_releases
  end
end
