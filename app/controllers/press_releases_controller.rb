class PressReleasesController < ApplicationController
  load_and_authorize_resource
  
  def recent
    @press_release = PressRelease.where("external = false").order('pr_date DESC').first
    @recent = PressRelease.where("id != ?", @press_release.id).order('pr_date DESC').limit(15)
    render :action => 'show'
  end

  def show
    @press_release = PressRelease.find(params[:id])
  end
  
end
