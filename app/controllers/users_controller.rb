class UsersController < ApplicationController
  load_and_authorize_resource
  
  
  def confirm
    @user = User.find_by_activation_code(params[:id])
    if @user.nil?
      redirect_to root_url, :notice => "Sorry, We could not find any record with this activation code"
    else
      @user.active!
      redirect_to "/set_password", :notice => "Your account is activated! Please login!"
    end
  end
  
  def change_password
    @user = current_user
  end
  
  def set_password
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Your password is set!"
    else
      render :action => 'set_password'
    end
  end
  
end