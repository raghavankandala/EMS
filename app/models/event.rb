class Event < ActiveRecord::Base
  attr_accessible :title, :description, :start_date, :end_date, :venue, :schedule, :contact, :city, :etype

  has_attached_file :venue, :styles => { :thumb => "100x100#", :small => "278x205>" }
  has_attached_file :rallyroute, :styles => { :thumb => "100x100#", :small => "278x205>" }

  validates_attachment_size :venue, :less_than => 1.megabytes  
  validates_attachment_content_type :venue, :content_type => ['image/jpeg', 'image/png']  
  validates_attachment_size :rallyroute, :less_than => 1.megabytes  
  validates_attachment_content_type :rallyroute, :content_type => ['image/jpeg', 'image/png']  
end
