class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  layout 'admin'

  def index
    @users = User.paginate(:per_page => 25, :page => (params[:page] || 1))
  end
  
  def new
    @user = User.new  
  end  
    
  def create  
    @user = User.new(params[:user])  
    @user.role_ids = params[:roles]
    if @user.save  
      
      redirect_to admin_users_path, :notice => "User Created!"  
    else  
      render "new"  
    end  
  end  
  
  def edit
  end
  
  def destroy
  end

end
