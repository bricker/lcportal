class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  
  helper_method :current_user 
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  
  def require_login
  	return true if current_user
  	session[:return_to] = request.fullpath
  	redirect_to login_path, alert: "You must be logged in to access this page." and return false
  end
  
  def require_admin
    return true if current_user.is_admin?
    redirect_to root_path, alert: "You are not authorized to access that page." and return false
  end
end
