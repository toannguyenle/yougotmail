class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # dont have to include all the field 
    #no need for ID, time stamps
    @user = User.new(params.require(:user).permit(:email, :password))
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  # EDIT CONTROLLER
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params.require(:user).permit(:email, :password))
      redirect_to users_path
    else
      render 'edit'
    end
  end

  # DELETE CONTROLLER
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
end
