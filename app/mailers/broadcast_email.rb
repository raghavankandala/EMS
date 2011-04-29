class BroadcastEmail < ActionMailer::Base
  default :from => "shreyaslive@gmail.com"

  def send_message(message)
    @content = message[:content]
    mail(:to => message[:email], :subject => message[:subject])
  end

end

