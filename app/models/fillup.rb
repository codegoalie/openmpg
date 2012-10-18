class Fillup < ActiveRecord::Base
  belongs_to :vehicle

  before_save :calculate_mpg, if: :need_to_calc

  default_scope order(:mileage)

  attr_accessible :filled_at, :mileage, :gallons, :ppg

  def per_hundred
    (100 / mpg) * ppg  if mpg && ppg
  end

  def distance
    mileage.to_f - previous_fillup.mileage if previous_fillup
  end

  def next_fillup
    vehicle.fillups.where('mileage > ? and id <> ?', mileage, id).last if vehicle
  end

  def previous_fillup
    vehicle.fillups.where('mileage < ? and id <> ?', mileage, id).last if vehicle
  end

  def need_to_calc
    (mileage_changed? || gallons_changed?) && previous_fillup
  end

  def calculate_mpg
    self.mpg = ((distance) / self.gallons.to_f).round(2)
  end

end
