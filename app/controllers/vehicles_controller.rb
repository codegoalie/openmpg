class VehiclesController < ApplicationController
  load_and_authorize_resource

  before_filter :load_meta_data, only: [:new, :edit]

  def index
  end

  def show
    @max_mpg = @vehicle.fillups.maximum(:mpg)
  end

  def new
  end

  def create
    @vehicle = Vehicle.new(params[:vehicle])
    current_user.vehicles << @vehicle
    if @vehicle.save
      redirect_to vehicles_path
    else
      load_meta_data
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def makes
    @make_options = load_makes(params['year'])
  end

  def models
    @model_options = load_models(params['make'], params['year'])
    puts @model_options
  end

  protected

    def load_meta_data
      @year_options = load_model_years
      @make_options = load_makes
      @model_options = load_models(@make_options.first)
    end

    def load_model_years
      @api_hash = CarQuery::Years.get
      (@api_hash['min_year'].to_i..@api_hash['max_year'].to_i).to_a.reverse
    end

    def load_makes(year=Date.today.year)
      CarQuery::Makes.get(year: year, sold_in_us: 1).map{|h| h['make_display']}
    end

    def load_models(make, year=Date.today.year)
      CarQuery::Models.get(make: make, year: year).map{|h| h['model_name']}
    end
end
