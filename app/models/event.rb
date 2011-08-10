class Event < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true

  attr_accessible :title, :description, :start_date, :end_date, :venue_location, :schedule, :contact, :city, :etype, :venue_directions_url, :venue, :rallyroute, :facebook_url, :twitter_url, :orkut_url, :cover_poster, :donate_box

  has_attached_file :venue, :styles => { :thumb => "100x100#", :small => "278x205>" }
  has_attached_file :rallyroute, :styles => { :thumb => "100x100#", :small => "278x205>" }
  has_attached_file :cover_poster, :styles => { :thumb => "100x100#", :small => "278x205>", :medium => "630x309>", :large => "900x>" }

  validates_attachment_size :venue, :less_than => 1.megabytes  
  validates_attachment_content_type :venue, :content_type => ['image/jpeg', 'image/png']  
  validates_attachment_size :rallyroute, :less_than => 1.megabytes  
  validates_attachment_content_type :rallyroute, :content_type => ['image/jpeg', 'image/png']  

  has_many :event_registrations
  has_many :registrations, :through => :event_registrations
  has_many :merchandises

  CITIES = ["Bangalore", "Mysore"]

  def self.upcoming
    Event.where("end_date >= ?", Time.now())
  end

  def self.recent
    Event.where("end_date <= ?", Time.now()).limit(3).order("start_date DESC")
  end

  def social_network?
    (!self.facebook_url.blank? || !self.twitter_url.blank? || !self.orkut_url.blank?)
  end

  def confirmed_supporters
    self.event_registrations.where("rtype = 1 and confirmed = true")
  end

  def unconfirmed_supporters
    self.event_registrations.where("rtype = 1 and confirmed = false")
  end
  
  def all_supporters
    self.event_registrations.where("rtype = 1")
  end

  def confirmed_volunteers
    self.event_registrations.where("rtype = 2 and confirmed = true")
  end

  def unconfirmed_volunteers
    self.event_registrations.where("rtype = 2 and confirmed = false")
  end
  
  def all_volunteers
    self.event_registrations.where("rtype = 2")
  end
  
  def all_registrants
    self.event_registrations
  end
  
end
