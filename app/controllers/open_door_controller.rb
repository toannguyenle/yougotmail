class OpenDoorController < ApplicationController
  def open
    # TO DO: devide model and look up by device id
    response = {}
    begin
      trackingcode = Trackingcode.where(code:params[:code]).first
      user = User.where(email:params[:email]).first
      if trackingcode.user_id == user.id
        response['status'] = "Access Granted"
      end
    rescue
      response['status'] = "Access Denied"
    ensure
      response['code'] = params[:code]
      response['device_id'] = params[:device_id]
      response['email'] = params[:email]
    end

    render json: response, status: 200
  end

  private
    def trackingcodes_params
      params.require(:trackingcode).permit(:code, :device_id, :email)
    end
end
