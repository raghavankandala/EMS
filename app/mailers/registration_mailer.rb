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
end
