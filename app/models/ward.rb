class Ward < ActiveRecord::Base
  attr_accessible :name, :ward_no, :total_population, :area, :lat, :lon
  has_many :localities
end
