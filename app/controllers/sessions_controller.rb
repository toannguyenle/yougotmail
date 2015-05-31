class SessionsController < ApplicationController
  def new
    # Present an empty login form
    @user = User.new
    @is_login = true
    @is_signup = false
  end

  def create
    # Find the user that is trying to log in    
    u = User.where(email: params[:user][:email]).first
    if u && u.authenticate(params[:password])
      # Store as a cookie in the users' browser the ID of them,
      # indicating that they are logged in
      session[:user_id] = u.id.to_s
      redirect_to user_path(current_user), notice: "Logged in."
    else
      # Go back to the login page
      redirect_to new_sessions_path, notice: "Email or password is invalid"
    end
  end

  def destroy
    reset_session
    redirect_to new_sessions_path, notice: "Logged out!"
  end
end