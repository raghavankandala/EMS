class Admin::AlertsController < ApplicationController
  load_and_authorize_resource
  layout 'admin'

  def index
    @alerts = Alert.all
  end
  
  def show
    @alert = Alert.find(params[:id])
  end
  
  def new
    @alert = Alert.new
  end
  
  def create
    @alert = Alert.new(params[:alert])
    if @alert.save
      flash[:notice] = "Successfully created Alert."
      redirect_to "/admin/alerts"
    else
      render :action => 'new'
    end
  end
  
  def edit
    @alert = Alert.find(params[:id])
  end
  
  def update
    @alert = Alert.find(params[:id])
    if @alert.update_attributes(params[:alert])
      flash[:notice] = "Successfully updated alert."
      redirect_to [:admin, @alert]
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @alert = Alert.find(params[:id])
    @alert.destroy
    flash[:notice] = "Successfully destroyed alert."
    redirect_to alerts_url
  end

end
