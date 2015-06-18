require 'httparty'
require 'json'
class OpenDoorController < ApplicationController
  def buzzin
    # TO DO: devide model and look up by device id
    response = {}
    response['status'] = "Access Denied"
    # Response time in seconds
    response['opentime'] = 0
    begin
      user = User.where(email:params[:email]).first
      trackingcode = Trackingcode.where(code:params[:code], user_id:user.id).first
      trackingcode_type = ''
      if trackingcode && trackingcode.is_active
        # Pre access granted processing
        # Delete if code only used once
        trackingcode_type = trackingcode.type
        if trackingcode.use_once_only
          trackingcode.delete()
        end

        # Granted Access after everything has been done
        response['status'] = "Access Granted"
      end

      # Send SMS Notification
      if user.allow_notifications
        # Send push notifications
        message = response['status'] + ' by code ' + params[:code] + ' ' + trackingcode_type + ' from ' + params[:device_id] + '.'
        tokens = {}
        tokens[:device] = 'toan_ip_6'
        tokens[:title]  = 'Front Door Buzzer'
        tokens[:user] = ENV['PUSHOVER_USER']
        tokens[:token] = ENV['PUSHOVER_BEEP']
        tokens[:message] = message

        HTTParty.post('https://api.pushover.net/1/messages.json', body:tokens)
      end

    rescue
      response['status'] = "Access Denied"
    ensure
      response['opentime'] = params[:opentime]
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
