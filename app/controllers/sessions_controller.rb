class SessionsController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create]
  def new
  end

  def create  
    user = User.authenticate(params[:email], params[:password])  
    if user  
      session[:user_id] = user.id  
      redirect_to root_url
      #redirect_back_or_default(root_url)
    else  
      flash.now.alert = "Invalid email or password"  
      render "new"  
    end  
  end  

  def destroy  
   session[:user_id] = nil  
   redirect_to root_url, :notice => "Logged out!"  
  end


end
