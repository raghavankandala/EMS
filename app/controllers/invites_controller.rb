class InvitesController < ApplicationController
  def index
    @invites = Invite.all
  end

  def show
    @invite = Invite.find(params[:id])
  end

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(params[:invite])
    if @invite.save
      redirect_to @invite, :notice => "Successfully created invite."
    else
      render :action => 'new'
    end
  end

  def edit
    @invite = Invite.find(params[:id])
  end

  def update
    @invite = Invite.find(params[:id])
    if @invite.update_attributes(params[:invite])
      redirect_to @invite, :notice  => "Successfully updated invite."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy
    redirect_to invites_url, :notice => "Successfully destroyed invite."
  end
end
