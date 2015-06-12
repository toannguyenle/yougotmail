class OpenDoorController < ApplicationController
  def open
    # TO DO: devide model and look up by device id
    response = {}
    response['status'] = "Access Denied"
    # Response time in seconds
    response['opentime'] = 0
    begin
      user = User.where(email:params[:email]).first
      trackingcode = Trackingcode.where(code:params[:code], user_id:user.id).first
      if trackingcode
        response['status'] = "Access Granted"
        response['opentime'] = 2
        # Post access granted processing
        # Check if code is only a one time thing
        # if trackingcode.use_once_only
        #   trackingcode.destroy()
        # end
      end
    rescue
      response['status'] = "Access Denied"
    ensure
      response['code'] = params[:code]
      response['device_id'] = params[:device_id]
      response['email'] = params[:email]
    end

    # Writing log file for user
    log = Log.new
    log.user = user
    log.params ="Email: #{params[:email]} - Code: #{params[:code]}"
    log.fromdevice = params[:device_id]
    log.response = response['status']
    log.save()

    # Business as usual
    render json: response, status: 200
  end

  def buzzin
    # TO DO: devide model and look up by device id
    response = {}
    response['status'] = "Access Denied"
    # Response time in seconds
    response['opentime'] = 0
    begin
      user = User.where(email:params[:email]).first
      trackingcode = Trackingcode.where(code:params[:code], user_id:user.id).first
      if trackingcode
        response['status'] = "Access Granted"
        response['opentime'] = 2
        # Post access granted processing
        # Check if code is only a one time thing
        # if trackingcode.use_once_only
        #   trackingcode.destroy()
        # end
      end
    rescue
      response['status'] = "Access Denied"
    ensure
      response['code'] = params[:code]
      response['device_id'] = params[:device_id]
      response['email'] = params[:email]
    end

    # Writing log file for user
    log = Log.new
    log.user = user
    log.params ="Email: #{params[:email]} - Code: #{params[:code]}"
    log.fromdevice = params[:device_id]
    log.response = response['status']
    log.save()

    # Business as usual
    render json: response, status: 200
  end

  private
    def trackingcodes_params
      params.require(:trackingcode).permit(:code, :device_id, :email)
    end
end
