class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to user_path(current_user)
    else
      # Present an empty login form
      @user = User.new
    end
  end

  def create
    # Find the user that is trying to log in    
    u = User.where(email: params[:user][:email]).first
    if u && u.authenticate(params[:user][:password])
      # Store as a cookie in the users' browser the ID of them,
      # indicating that they are logged in
      session[:user_id] = u.id.to_s
      redirect_to user_path(current_user), notice: "Logged in."
    else
      # Go back to the login page
      redirect_to login_path, notice: "Email or password is invalid"
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "Logged out!"
  end
end