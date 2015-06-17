require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'
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
      if trackingcode && trackingcode.is_active
        # Pre access granted processing
        # Send SMS Notification
        if user.allow_notifications
          # put your own credentials here 
          account_sid = ENV['TWILIO_SID']
          auth_token = ENV['TWILIO_TOKEN']
           
          # set up a client to talk to the Twilio REST API 
          @client = Twilio::REST::Client.new account_sid, auth_token 
          
          message_body = (Time.now).to_s + ' - Front Door was opened by code: ' + params[:code] + ' ' + trackingcode.type + ' by ' + params[:device_id]

          @client.account.messages.create({
            :from => '+14153196877', 
            :to => user.phone, 
            :body => message_body,  
          })
        end

        # Delete if code only used once
        if trackingcode.use_once_only
          trackingcode.delete()
        end

        # Granted Access after everything has been done
        response['status'] = "Access Granted"
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
