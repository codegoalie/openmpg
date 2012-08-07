class Fillup < ActiveRecord::Base
  belongs_to :vehicle

  before_save :calculate_mpg

  default_scope order(:mileage)

  attr_accessible :filled_at, :mileage, :gallons, :ppg

  def next_fillup
    vehicle.fillups.where('mileage < ?', mileage).first if vehicle
  end

  def previous_fillup
    vehicle.fillups.where('mileage > ?', mileage).first if vehicle
  end

  def calculate_mpg
    if (mileage_changed? || gallons_changed?) && prev_fillup = previous_fillup
      prev_fillup.update_attribute(:mpg, (mileage - prev_fillup.mileage) / gallons)
    end

    if mileage_changed? && next_one = next_fillup
      self.mpg = (next_one.mileage - mileage) / next_one.gallons
    end
  end
end
