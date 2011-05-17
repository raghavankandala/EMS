class Admin::QuickLinksController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  
  def index
    @quick_links = QuickLink.all
  end

  def show
    @quick_link = QuickLink.find(params[:id])
  end

  def new
    @quick_link = QuickLink.new
  end

  def create
    @quick_link = QuickLink.new(params[:quick_link])
    if @quick_link.save
      redirect_to [:admin, @quick_link], :notice => "Successfully created quick link."
    else
      render :action => 'new'
    end
  end

  def edit
    @quick_link = QuickLink.find(params[:id])
  end

  def update
    @quick_link = QuickLink.find(params[:id])
    if @quick_link.update_attributes(params[:quick_link])
      redirect_to [:admin, @quick_link], :notice  => "Successfully updated quick link."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @quick_link = QuickLink.find(params[:id])
    @quick_link.destroy
    redirect_to admin_quick_links_url, :notice => "Successfully destroyed quick link."
  end
end
