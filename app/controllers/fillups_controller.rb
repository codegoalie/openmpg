class FillupsController < ApplicationController
  load_and_authorize_resource

  def new
    @vehicle = Vehicle.find(params[:id])
    @fillup = @vehicle.fillups.new
  end
end
