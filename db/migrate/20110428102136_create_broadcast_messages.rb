class CreateBroadcastMessages < ActiveRecord::Migration
  def self.up
    create_table :broadcast_messages do |t|
      t.string :subject
      t.text :content
      t.string :from
      t.text :to

      t.timestamps
    end
  end

  def self.down
    drop_table :broadcast_messages
  end
end
