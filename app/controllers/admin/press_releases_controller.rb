class Admin::PressReleasesController < ApplicationController
  load_and_authorize_resource 
  layout 'admin'
  
  def index
    @press_releases = PressRelease.paginate(:per_page => 20, :page => (params[:page] || 1), :order => "pr_date DESC")
  end
    
  def new
    @press_release = PressRelease.new
  end
  
  def create
    @press_release = PressRelease.new(params[:press_release])
    if @press_release.save
      redirect_to '/press_releases', :notice => "Successfully created press release."
    else
      render :action => 'new'
    end
  end
  
  def edit
    @press_release = PressRelease.find(params[:id])
  end
  
  def update
    @press_release = PressRelease.find(params[:id])
    if @press_release.update_attributes(params[:press_release])
      redirect_to '/press_releases', :notice  => "Successfully updated press release."
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @press_release = PressRelease.find(params[:id])
    @press_release.destroy
    redirect_to press_releases_url, :notice => "Successfully destroyed press release."
  end
  
end
