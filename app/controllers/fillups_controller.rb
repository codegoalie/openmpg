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

  def edit
    @fillup = Fillup.find(params[:id])
    @vehicle = @fillup.vehicle
  end

  def update
    @fillup = Fillup.find(params[:id])
    @vehicle = @fillup.vehicle

    if @fillup.update_attributes(params[:fillup])
      flash[:success] = "Fillup updated."
      redirect_to @vehicle
    else
      render 'edit'
    end
  end
end
