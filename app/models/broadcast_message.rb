class BroadcastMessage < ActiveRecord::Base

  def process_message
    recepients = to.split(",")

    recepients.each do |recepient|
      message = BroadcastEmail.send_message({:email => recepient, :subject => subject, :content => content})
      message.deliver
    end
  end

end

