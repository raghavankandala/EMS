class AddCityToLocalitiesAndWards < ActiveRecord::Migration
  def self.up
    add_column "localities", "city", :string
    add_column "wards", "city", :string
  end

  def self.down
    remove_column "localities", "city"
    remove_column "wards", "city"
  end
end
