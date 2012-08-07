class FillupsController < ApplicationController
  load_and_authorize_resource

  def new
    @vehicle = Vehicle.find(params[:id])
    @fillup = @vehicle.fillups.new
  end

  def create
    @vehicle = Vehicle.find(params[:id])
    if @fillup = @vehicle.fillups.create(params[:fillup])
      redirect_to @vehicle
    else
      render :new
    end
  end
end
