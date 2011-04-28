class RegistrationMailer < ActionMailer::Base
  helper ApplicationHelper 

  default :from => "info@saaku.in"
  
  def registration_confirmation(registration)
    @registration = registration
    subject = "[Saaku] " << @registration.rtype == 2 ? " Volunteer Registration Confirmation" : " Registration Confirmation" 
    mail(:to => registration.email, :subject => subject)
  end

  def event_participation_confirmation(eventregistration)
    @er = eventregistration
    subject = "[Saaku] " << @er.rtype == 2 ? " Volunteer Registration Confirmation" : " Event Registration Confirmation" 
    mail(:to => eventregistration.registration.email, :subject => subject)
  end

  def send_invitation(event, invitee_email, inviter_name)
    @inviter_name = inviter_name
    @event = event
    mail(:to => invitee_email, :subject => "[Saaku] You are invited to an Anti Corruption event") 
  end
end
