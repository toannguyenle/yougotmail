class UsersController < ApplicationController
  before_action :make_sure_logged_in, only: [:edit, :update, :destroy, :index, :show, :log]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :log]
  def index
    @users = User.all
  end

  def show
    begin
      @trackingcodes = Trackingcode.where(user_id:@user.id)
      @logs = Log.where(user_id:@user.id).reverse.first(3)
    rescue
      redirect_to login_path, notice: "Please log in."
    end
  end

  def log
    begin
      @logs = Log.where(user_id:@user.id).reverse.first(20)
    rescue
      redirect_to user_path(current_user), notice: "Can't access logs."
    end
  end

  def new
    @user =User.new
    # So the sign up link doesn't show when not needed
    @is_signup = true
    @is_login = false
  end  

  def create
    user = User.new(user_params)
    if user.save
      # the moment you sign up it logs  you in
      session[:user_id] = user.id.to_s
      redirect_to user_path(current_user), notice: "Welcome back, #{current_user.name}!"
    else
      redirect_to signup_path, notice: "Please sign up."
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user), notice: "#{current_user.name}, your info is up to date."
    else
      redirect_to edit_user_path(@user), notice: "We have trouble updating your info, please do so again."
    end
  end

  def destroy
    # If person is logged in than log them out
    if @user.id === current_user.id
      reset_session
    end
    # perform destroy
    @user.destroy
    reset_session
    redirect_to login_path, notice: "Account deleted."
  end
  
  private
    # Make sure only logged in user can see other user list
    def make_sure_logged_in
      if !current_user 
        redirect_to login_path, notice: "Please log in."
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      begin
        @user = User.find(params[:id])
      rescue
        redirect_to login_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :accept_terms, :allow_notifications)
    end
end