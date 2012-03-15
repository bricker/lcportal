class PasswordResetsController < ApplicationController
  skip_before_filter :require_login
  before_filter :check_login
  before_filter :get_user, only: [:edit, :update]
  before_filter :check_expiration, only: [:edit, :update]
  respond_to :html
  
  def create
    if user = User.find_by_email(params[:email])
      user.send_password_reset
      redirect_to login_path, notice: "An e-mail has been sent to <strong>#{params[:email]}</strong> with reset instructions."
    else
      redirect_to new_password_reset_path, alert: "The e-mail address <strong>#{params[:email]}</strong> is not in our records."
    end
  end
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to login_path, notice: "Your password has been reset."
    else
      render :edit
    end
  end
  
  protected
    def check_login
      return true if !current_user
      redirect_to root_path, notice: "You are logged in as #{current_user.name}. You can change your password in your profile." and return false
    end
    
    def get_user
      @user = User.find_by_password_reset_token!(params[:id])
      rescue
        redirect_to login_path, alert: "Invalid token."
    end
    
    def check_expiration
      if @user.password_reset_requested_at < 30.minutes.ago
        redirect_to new_password_reset_path, alert: "Password reset request has expired. Your password was not changed." and return false
      end
    end
end
