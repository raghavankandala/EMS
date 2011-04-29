class Admin::BroadcastMessagesController < ApplicationController

  load_and_authorize_resource
  layout 'admin'

  def index
    @broadcast_messages = BroadcastMessage.paginate :page => params[:page], :per_page => 10
  end

  def new
  end

  def create
    if @broadcast_message.save
      @broadcast_message.delay.process_message
      flash[:notice] = "Emails are currently being sent"
      redirect_to admin_broadcast_messages_path
    else
      flash[:error] = "Something went wrong."
      redirect_to admin_broadcast_messages_path
    end
  end

  def destroy
    @broadcast_message.destroy
    flash[:notice] = "Successfully deleted message."
    redirect_to admin_broadcast_messages_path
  end

end

