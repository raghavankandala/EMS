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
    @registration = Registration.new({:rtype => 1, :city => @event.city})
  end

  def attendees
    @event = Event.find(params[:id])
    @locs = @event.confirmed_supporters.collect {|c| {:lat => c.registration.locality.lat, :lon => c.registration.locality.lon } }.to_json
    logger.info @locs
  end

  def volunteer
    @event = Event.find(params[:id])
    @registration = Registration.new({:rtype => 2, :city => @event.city})
  end

  def invite
    @event = Event.find(params[:id])
    @invite = Invite.new()
  end

  def send_invite
    @event = Event.find(params[:id])
    @invite = Invite.new(params[:invite])
    if verify_recaptcha(:model => @invite, :message => "Invalid reCAPTCHA!") && @invite.save
      @invite.send_invite!(@event)
      redirect_to @event, :notice => "Your invite has been sent!"
    else
      render :action => 'invite'
    end
  end

  def register
    @event = Event.find(params[:id])
    @registration = Registration.new(params[:registration])
    @reg = Registration.find_by_email(@registration.email)
    unless verify_recaptcha(:model => @registration, :message => "Invalid reCAPTCHA!") && @registration.valid?
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
        RegistrationMailer.event_participation_confirmation(@er).deliver
        redirect_to @event, :notice => "Thank you for extending your support to the event! A confirmation email has been sent to your email address"
        return;
      else
        if @registration.rtype == @er.rtype
          redirect_to @event, :notice => "You have already registered for this event!"
          return;
        else
          @er.update_attributes({:rtype => @registration.rtype, :guid => EventRegistration.gen_guid})
          @er.registration.update_attributes({:volunteering_area => @registration.volunteering_area, :volunteer_description => @registration.volunteer_description})
          RegistrationMailer.event_participation_confirmation(@er).deliver
          redirect_to @event, :notice => "Thank you for extending your support to the event! A confirmation email has been sent to your email address"
          return;
        end
      end
    end
    if @registration.save
      EventRegistration.create!({:event => @event, :registration => @registration, :rtype => @registration.rtype, :guid => @registration.guid })
      RegistrationMailer.registration_confirmation(@registration).deliver
      redirect_to @event, :notice => "Thank you for extending your support to the event! A confirmation email has been sent for you to confirm your participation"
      return;
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
         message = "Sorry! Could not find a registration entry with the given guid! Please make sure the link is copy pasted properly or send an email to admin@saaku.in with your name and email address with which you registered."
      else
         @er.mark_confirmed
         message = "Thank you for confirming your participation in the event " if @er.rtype == 1
         message = "Thank you for your willingness to volunteer for the event " if @er.rtype == 1
         message << "<b>#{@er.event.title}</b>! Please spread a word about this event to your friends and colleagues by <A href='/events/#{@er.event.cached_slug}/invite'>Inviting</A> them to register!"
      end
      redirect_to @er.event, :notice => message
   end

  def fetch_attendees
    @event = Event.find(params[:id])
    render :update do |page|
      page.replace_html 'sk_attending_count', @event.confirmed_supporters.length
      page.replace_html 'sk_may_attend_count', @event.unconfirmed_supporters.length
    end
  end

end
