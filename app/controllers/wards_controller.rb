class WardsController < ApplicationController
  def index
    @wards = Ward.all
  end

  def show
    @ward = Ward.find(params[:id])
  end

  def new
    @ward = Ward.new
  end

  def create
    @ward = Ward.new(params[:ward])
    if @ward.save
      redirect_to @ward, :notice => "Successfully created ward."
    else
      render :action => 'new'
    end
  end

  def edit
    @ward = Ward.find(params[:id])
  end

  def update
    @ward = Ward.find(params[:id])
    if @ward.update_attributes(params[:ward])
      redirect_to @ward, :notice  => "Successfully updated ward."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @ward = Ward.find(params[:id])
    @ward.destroy
    redirect_to wards_url, :notice => "Successfully destroyed ward."
  end
end
