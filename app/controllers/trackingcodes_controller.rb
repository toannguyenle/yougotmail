class TrackingcodesController < ApplicationController
  before_action :make_sure_logged_in, only: [:index, :show, :create, :destroy, :update]

  def show
    @trackingcode = Trackingcode.find(params[:id])
  end

  def new
    @trackingcode = Trackingcode.new
  end

  def create
    trackingcode = Trackingcode.new(trackingcode_params)
    trackingcode.user = current_user
    if trackingcode.save
      redirect_to user_path(current_user)
    else
      redirect_to new_trackingcode_path, notice: "Failed Saving New Code"
    end
  end

  def edit
    @trackingcode = Trackingcode.find(params[:id])
  end

  def update
    @trackingcode = Trackingcode.find(params[:id])
    if @trackingcode.update_attributes(trackingcode_params)
      redirect_to user_path(current_user), notice: "Code #{@trackingcode.code} updated."
    else
      redirect_to edit_trackingcode_path(@trackingcode), notice: "Please update code again."
    end
  end

  def destroy
    trackingcode = Trackingcode.find(params[:id])
    trackingcode.destroy
    redirect_to user_path(current_user), notice: "Code #{params[:id]} deleted."
  end

  private

    def trackingcode_params
      params.require(:trackingcode).permit(:code, :type, :valid_date, :use_once_only, :valid_from, :valid_to)
    end
    # Make sure only logged in user can see other user list
    def make_sure_logged_in
      if !current_user 
        redirect_to login_path
      end
    end
end