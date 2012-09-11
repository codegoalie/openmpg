class Fillup < ActiveRecord::Base
  belongs_to :vehicle

  before_save :calculate_mpg

  default_scope order(:mileage)

  attr_accessible :filled_at, :mileage, :gallons, :ppg

  def next_fillup
    vehicle.fillups.where('mileage > ? and id <> ?', mileage, id).last if vehicle
  end

  def previous_fillup
    vehicle.fillups.where('mileage < ? and id <> ?', mileage, id).last if vehicle
  end

  def calculate_mpg
    if mileage_changed? && next_fillup
      set_nexts_mpg
    end

    if (mileage_changed? || gallons_changed?) && previous_fillup
      set_own_mpg
    end
  end

  def per_hundred
    (100 / mpg) * ppg  if mpg && ppg
  end

  def set_nexts_mpg
    next_fillup.update_attribute(:mpg, ((next_fillup.mileage.to_f - mileage) / next_fillup.gallons).round(2))
  end

  def set_own_mpg
    self.mpg = ((self.mileage.to_f - previous_fillup.mileage) / self.gallons).round(2)
  end
end
