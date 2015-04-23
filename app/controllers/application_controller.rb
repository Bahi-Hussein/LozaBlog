class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?


  def current_user
  	#if session exists - find user who has hash user_id - if found
  	#it will return the user or false
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  # will be use only in controller
  def require_user
  	if !logged_in? 
  		flash[:danger] = "You must be logged in"
  		redirect_to :root
  	end
  end
end
