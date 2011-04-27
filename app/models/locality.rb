class Locality < ActiveRecord::Base
  set_table_name 'bangalorepoints'
  attr_accessible :name, :lat, :lon
end
