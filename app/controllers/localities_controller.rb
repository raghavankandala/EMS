class LocalitiesController < ApplicationController
  def index
    @localities = Locality.all
  end

  def show
    @locality = Locality.find(params[:id])
  end

  def new
    @locality = Locality.new
  end

  def create
    @locality = Locality.new(params[:locality])
    if @locality.save
      redirect_to @locality, :notice => "Successfully created locality."
    else
      render :action => 'new'
    end
  end

  def edit
    @locality = Locality.find(params[:id])
  end

  def update
    @locality = Locality.find(params[:id])
    if @locality.update_attributes(params[:locality])
      redirect_to @locality, :notice  => "Successfully updated locality."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @locality = Locality.find(params[:id])
    @locality.destroy
    redirect_to localities_url, :notice => "Successfully destroyed locality."
  end
end
