class Invite < ActiveRecord::Base
  attr_accessible :inviter_name, :inviter_email, :invitees
   validates_presence_of :inviter_name, :message => "Please enter your name"
   validates_presence_of :inviter_email, :message => "Please enter your email"
   validates_presence_of :invitees, :message => "Please enter atleast one email address to send the invitation."


   validates_format_of :inviter_email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i, :unless => Proc.new { |c| c.inviter_email.blank? }

   def validate
      unless self.invitees.blank?
         _invitees = self.invitees.split(',')
         _invitees.each do |invitee|
            self.errors.add("email address is invalid") if invitee.strip.match(/^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i).nil?
         end
      end
   end

  def send_invite!(event)
    invitees.each do |invitee_email|
      RegistrationMailer.send_invitation(event, invitee_email, inviter_name).deliver
    end
  end

end
