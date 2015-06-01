class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  # Memoization - only read the first time - look it up
  helper_method :current_user
  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end
end
