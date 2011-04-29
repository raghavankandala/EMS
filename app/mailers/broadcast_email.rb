class BroadcastEmail < ActionMailer::Base
  default :from => "shreyaslive@gmail.com"

  def send_message(user)
    @user = user[:content]
    mail(:to => user[:email], :subject => user[:subject])
  end

end

