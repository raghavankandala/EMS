class Locality < ActiveRecord::Base
  attr_accessible :name, :lat, :lon

  def self.available(city)
    self.where("city = ?", city).length != 0
  end
end
