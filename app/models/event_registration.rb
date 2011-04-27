class EventRegistration < ActiveRecord::Base
  belongs_to :event
  belongs_to :registration

  def self.gen_guid
    Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end

  def mark_confirmed
    self.update_attributes({:guid => nil, :confirmed => true, :confirmed_at => Time.now()})
  end

end
