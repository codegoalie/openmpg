class FillupObserver < ActiveRecord::Observer

  def after_save(fill_up)
    calc_next(fill_up)
    calc_prev(fill_up)
  end

  private

    def calc_next(fill_up)
      if fill_up.mileage_changed? && next_fillup = fill_up.next_fillup
        next_fillup.calculate_mpg
        next_fillup.save!
      end
    end

    def calc_prev(fill_up)
      if fill_up.mileage_changed? && prev_fillup = fill_up.previous_fillup
        prev_fillup.calculate_mpg
        prev_fillup.save!
      end
    end
end
