class FillupObserver < ActiveRecord::Observer

  def after_save(fill_up)
      if fill_up.mileage_changed? && next_fillup = fill_up.next_fillup
        next_fillup.calculate_mpg
        next_fillup.save
      end
  end
end
