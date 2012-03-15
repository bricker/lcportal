class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  
  helper_method :current_user 
  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  
  def require_login
  	return true if current_user
  	session[:return_to] = request.fullpath
  	redirect_to login_path and return false
  end
  
  def require_admin
    return true if current_user.is_admin?
    redirect_to root_path and return false
  end
end
