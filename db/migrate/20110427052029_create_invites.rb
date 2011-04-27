class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.string :inviter_name
      t.string :inviter_email
      t.text :invitees
      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end
end
