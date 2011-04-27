class EventsController < ApplicationController
  load_and_authorize_resource 

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to @event, :notice => "Successfully created event."
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to @event, :notice  => "Successfully updated event."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, :notice => "Successfully destroyed event."
  end

  def attend
    @event = Event.find(params[:id])
    @registration = Registration.new({:rtype => 1})
  end

  def attendees
    @event = Event.find(params[:id])
  end

  def volunteer
    @event = Event.find(params[:id])
    @registration = Registration.new({:rtype => 2})
  end

  def invite
  end

  def register
    @event = Event.find(params[:id])
    @registration = Registration.new(params[:registration])
    @reg = Registration.find_by_email(@registration.email)
    unless verify_recaptcha(:model => @registration, :message => "Invalid reCAPTCHA!")
      if @registration.rtype == 1
        render :action => 'attend'
      elsif @registration.rtype == 2
        render :action => 'volunteer'
      end
      return;
    end
    unless @reg.nil?
      @er = EventRegistration.where("event_id = ? and registration_id = ?", @event.id, @reg.id).first
      if @er.nil?
        @er = EventRegistration.create!({:event => @event, :registration => @reg, :rtype => @registration.rtype, :guid => EventRegistration.gen_guid})
        RegistrationMailer.event_registration_confirmation(@er).deliver
        redirect_to @event, :notice => "Thank you for extending your support to the event! A confirmation email has been sent to your email address"
        return;
      else
        if @registration.rtype == @er.rtype
          redirect_to @event, :notice => "A registration with this email address already exists!"
          return;
        else
          @er.update_attributes({:rtype => @registration.rtype, :guid => EventRegistration.gen_guid})
          RegistrationMailer.event_participation_confirmation(@er).deliver
          redirect_to @event, :notice => "Thank you for extending your support to the event! A confirmation email has been sent to your email address"
        end
      end
    end
    if @registration.save
      EventRegistration.create!({:event => @event, :registration => @registration, :rtype => @registration.rtype, :guid => @registration.guid })
      RegistrationMailer.registration_confirmation(@registration).deliver
      redirect_to @event, :notice => "Thank you for extending your support to the event! A confirmation email has been sent for you to confirm your participation"
    else
      if @registration.rtype == 1
        render :action => 'attend'
      elsif @registration.rtype == 2
        render :action => 'volunteer'
      end
    end    
  end

  def confirm_participation
      @er = EventRegistration.find_by_guid(params[:guid])
      if @er.nil?
         flash[:error] = "Sorry! Could not find a registration entry with the given guid! Please make sure the link is copy pasted properly or send an email to admin@saaku.in with your name and email address with which you registered."
      else
         @er.mark_confirmed
         flash[:notice] = "Thank you for confirming your participation in the event <b>#{@er.event.title}</b>! Please spread a word about this event to your friends and colleagues by <A href='/events/#{@er.event.id}/invite'>Inviting</A> them to register!"
      end
      redirect_to @er.event
   end

end
