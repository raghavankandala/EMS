class QuickLinksController < ApplicationController
  load_and_authorize_resource
  
  def index
    @quick_links = QuickLink.all
  end

  def show
    @quick_link = QuickLink.find(params[:id])
  end

end
