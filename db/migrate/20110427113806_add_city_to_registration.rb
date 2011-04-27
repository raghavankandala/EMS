class AddCityToRegistration < ActiveRecord::Migration
  def self.up
    add_column "registrations", "city", :string
  end

  def self.down
    remove_column "registrations", "city"
  end
end
