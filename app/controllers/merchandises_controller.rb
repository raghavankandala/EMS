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

end
