class TrackingcodesController < ApplicationController

  def index
    # trackingcodes = Trackingcode.all
    trackingcodes = params
    render json: trackingcodes, status: 200
  end

  def show
    # trackingcode = Trackingcode.find(params[:id])
    trackingcode = trackingcode_params
    render json: trackingcode, status: 201
  end


  def create
    trackingcode = trackingcode_params
    # trackingcode = Trackingcode.create(trackingcode_params)
    render json: trackingcode, status: 201
  end

  # def update
  #   trackingcode = Trackingcode.find(params[:id])
  #   trackingcode.update_attributes(trackingcode_params)
  #   render nothing: true, status: 204
  # end

  # def destroy
  #   trackingcode = Trackingcode.find(params[:id])
  #   trackingcode.destroy
  #   render nothing: true, status: 204
  # end

  # private

  # def trackingcode_params
  #   params.require(:trackingcode).permit(:email, :trackingcode, :id)
  # end

end