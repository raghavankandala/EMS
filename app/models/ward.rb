class Ward < ActiveRecord::Base
  attr_accessible :name, :ward_no, :total_population, :area, :lat, :lon
  has_many :localities

  def self.available(city)
    self.where("city = ?", city).length != 0
  end
end
