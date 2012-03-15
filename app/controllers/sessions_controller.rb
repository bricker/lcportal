class SessionsController < ApplicationController
  skip_before_filter :require_login, except: :destroy
  
  respond_to :html
  
  def new
    redirect_to statements_path if current_user
  end
  
  def create
    if user = User.authenticate(params[:email], params[:password])
      if params[:remember]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to statements_path, notice: "Logged in."
    else
      flash.now.alert = "Invalid login information."
      render 'new'
    end    
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to login_path, notice: "Logged out."
  end

end
