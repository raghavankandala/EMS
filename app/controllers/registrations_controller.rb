class RegistrationsController < ApplicationController
  def index
    @registrations = Registration.all
  end

  def show
    @registration = Registration.find(params[:id])
  end

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(params[:registration])
    if @registration.save
      redirect_to @registration, :notice => "Successfully created registration."
    else
      render :action => 'new'
    end
  end

  def edit
    @registration = Registration.find(params[:id])
  end

  def update
    @registration = Registration.find(params[:id])
    if @registration.update_attributes(params[:registration])
      redirect_to @registration, :notice  => "Successfully updated registration."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy
    redirect_to registrations_url, :notice => "Successfully destroyed registration."
  end

    def confirm
      @registration = Registration.find_by_guid(params[:id])
      if @registration.nil?
         #flash[:error] = "Sorry! Could not find a registration entry with the given guid! Please make sure the link is copy pasted properly or send an email to admin@saaku.in with your name and email address with which you registered."
      else
         @registration.mark_confirmed
         @er = EventRegistration.find_by_guid(params[:id])
         @er.mark_confirmed
         flash[:notice] = "You registration for the event is confirmed! Please spread a word about this event to your friends and colleagues by <A href='/events/<%= @er.event.id %>/invite'>Inviting</A> them to register!"
         redirect_to @er.event 
      end
   end

end
