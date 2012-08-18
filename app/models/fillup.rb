class Fillup < ActiveRecord::Base
  belongs_to :vehicle

  before_save :calculate_mpg

  default_scope order(:mileage)

  attr_accessible :filled_at, :mileage, :gallons, :ppg

  def next_fillup
    vehicle.fillups.where('mileage > ?', mileage).last if vehicle
  end

  def previous_fillup
    vehicle.fillups.where('mileage < ?', mileage).first if vehicle
  end

  def calculate_mpg
    if mileage_changed? && next_one = next_fillup
      next_one.update_attribute(:mpg, ((next_one.mileage - mileage) / next_one.gallons).round(2))
    end

    if (mileage_changed? || gallons_changed?) && previous_one = previous_fillup
      self.mpg = ((mileage - previous_one.mileage) / gallons).round(2)
    end
  end
end
