class FillupsController < ApplicationController
  load_and_authorize_resource
  before_filter :parse_time, only: [:create, :update]

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

  def parse_time
    if params[:fillup][:filled_at].present?
      raw_time = DateTime.strptime(params[:fillup][:filled_at], '%m/%d/%y %l:%M %P')
      params[:fillup][:filled_at] = Time.new(raw_time.year, raw_time.month, raw_time.day, raw_time.hour, raw_time.minute, raw_time.second)

    end
  end
end
