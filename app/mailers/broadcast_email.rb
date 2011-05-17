class BroadcastEmail < ActionMailer::Base
  default :from => "shreyaslive@gmail.com"

<<<<<<< HEAD:app/mailers/broadcast_email.rb
  def send_message(user)
    @content = user[:content]
    mail(:to => user[:email], :subject => user[:subject])
=======
  def send_message(message)
    @content = message[:content]
    mail(:to => message[:email], :subject => message[:subject])
>>>>>>> 643eedfd528b7abafa8e84747ef8a4115c65491d:app/mailers/broadcast_email.rb
  end

end

