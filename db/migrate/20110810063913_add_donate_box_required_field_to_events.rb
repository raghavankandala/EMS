class AddDonateBoxRequiredFieldToEvents < ActiveRecord::Migration
  def self.up
    add_column "events", "donate_box", :boolean
  end

  def self.down
    remove_column "events", "donate_box"
  end
end
