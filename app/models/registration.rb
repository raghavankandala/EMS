class Registration < ActiveRecord::Base
  attr_accessible :name, :mobile, :email, :address, :locality_id, :ward_id, :confirmed, :guid, :student, :institution, :volunteering_area, :volunteer_description, :rtype, :confirmed_at
  belongs_to :locality
  has_many :event_registrations
  has_many :events, :through => :event_registrations

  RTYPE = { "SUPPORTER" => 1, "VOLUNTEER" => 2, "CHAMPION" => 3 }
  RTYPE_ARR = [ ["SUPPORTER", 1], ["VOLUNTEER", 2], ["CHAMPION", 3] ]

  COLLEGES = ["ST. JOSEPHS COLLEGE", "BMS COLLEGE"]

  validates_presence_of :name, :email
  #validates_uniqueness_of :email, :unless => Proc.new { |c| c.email.blank? }
  validates_presence_of :locality_id, :message => "Please select the locality where you live."
  validates_presence_of :institution, :if => Proc.new { |c| c.student? }
  validates_presence_of :volunteering_area, :if => Proc.new { |c| c.rtype == 2 }
  validates_presence_of :volunteer_description, :if => Proc.new { |c| c.rtype == 2 }
  validates_numericality_of :mobile, :message => "Mobile number should not have characters", :unless => Proc.new {|c| c.mobile.blank? }

  validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i, :message => "Email address format is invalid" ,:unless => Proc.new { |c| c.email.blank? }

  def before_create
    self.guid = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end

  def mark_confirmed
    self.update_attributes({:guid => nil, :confirmed => true, :confirmed_at => Time.now()})
  end
  
end
