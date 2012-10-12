class Fillup < ActiveRecord::Base
  belongs_to :vehicle

  before_save :calculate_mpg

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

  private 

    def calculate_mpg
      if mileage_changed? && next_fillup
        set_nexts_mpg
      end

      if (mileage_changed? || gallons_changed?) && previous_fillup
        set_own_mpg
      end
    end

    def set_nexts_mpg
      # override mass assignment
      new_distance =  next_fillup.mileage - mileage
      new_mpg = (new_distance / next_fillup.gallons.to_f).round(2)
      next_fillup.update_attribute(:mpg, new_mpg)
    end

    def set_own_mpg
      self.mpg = ((distance) / self.gallons.to_f).round(2)
    end

end
