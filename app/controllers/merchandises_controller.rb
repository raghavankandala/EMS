class MerchandisesController < ApplicationController
  load_and_authorize_resource
  
  def index
    if params[:event_id].nil? 
      @merchandises = Merchandise.order("created_at DESC").paginate(:per_page => 15, :page => params[:page] || 1)
    else
      @event = Event.find(params[:event_id])
      @merchandises = @event.merchandises.order("created_at DESC").paginate(:per_page => 15, :page => params[:page] || 1)
    end
  end

  def show
    @merchandise = Merchandise.find(params[:id])
  end

  def new
    @merchandise = Merchandise.new
    @merchandise.event =  Event.find(params[:event_id]) unless params[:event_id].nil?
  end

  def create
    @merchandise = Merchandise.new(params[:merchandise])
    if @merchandise.save
      if @merchandise.event.nil?
        redirect_to '/artwork', :notice => "Successfully created merchandise."
      else
        redirect_to event_merchandises_path(@merchandise.event), :notice => "Successfully created merchandise."
      end
    else
      render :action => 'new'
    end
  end


end
