class SessionsController < ApplicationController
  skip_before_filter :require_login, except: :destroy
  
  respond_to :html
  
  def new
    redirect_to statements_path, notice: "You are logged in as #{current_user.name}" if current_user
  end
  
  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to statements_path, notice: "Logged in."
    else
      flash.now.alert = "Invalid login information."
      render 'new'
    end    
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out."
  end

end
