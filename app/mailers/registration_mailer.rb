class RegistrationMailer < ActionMailer::Base
  default :from => "info@saaku.in"
  
  def registration_confirmation(registration)
    @registration = registration
    mail(:to => registration.email, :subject => "[Saaku] Registration Confirmation")
  end

  def event_participation_confirmation(eventregistration)
    @er = eventregistration
    mail(:to => eventregistration.registration.email, :subject => "[Saaku] Event Registration Confirmation")
  end

  def send_invitation(event, invitee_email, inviter_name)
    @inviter_name = inviter_name
    @event = event
    mail(:to => invitee_email, :subject => "[Saaku] You are invited to an Anti Corruption event") 
  end
end
