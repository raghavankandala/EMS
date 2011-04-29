class MerchandisesController < ApplicationController
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

  def edit
    @merchandise = Merchandise.find(params[:id])
  end

  def update
    @merchandise = Merchandise.find(params[:id])
    if @merchandise.update_attributes(params[:merchandise])
      redirect_to @merchandise, :notice  => "Successfully updated merchandise."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @merchandise = Merchandise.find(params[:id])
    @merchandise.destroy
    redirect_to merchandises_url, :notice => "Successfully destroyed merchandise."
  end
end
