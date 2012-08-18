require 'spec_helper'

describe Fillup do
  describe 'calculating mpgs' do
    before(:each) do
      @vehicle = Vehicle.make!
      @first =  Fillup.make!(filled_at: Time.now - 5.minutes, mileage: 100, gallons: 10)
      @second =  Fillup.make!(filled_at: Time.now - 3.minutes, mileage: 120, gallons: 11)
      @last =  Fillup.make!(filled_at: Time.now, mileage: 150, gallons: 15)
      @vehicle.fillups << @first << @second << @last
    end

    it 'should calculate its own mpg on save when gallons are changed' do
      @new_gallons = 15
      @second.update_attribute(:gallons, @new_gallons)
      @second.mpg.should== ((@second.mileage - @first.mileage)/@second.gallons).round(2)
    end

    it 'should calculate the next fillups mpg on save when mileage is changed' do
      @new_mileage = 130
      @second.update_attribute(:mileage, @new_mileage)
      @last.reload
      @last.mpg.should== ((@last.mileage - @second.mileage)/@last.gallons).round(2)
    end

    it 'should calculate the its own mpg on save when mileage is changed' do
      @new_mileage = 130
      @second.update_attribute(:mileage, @new_mileage)
      @second.mpg.should== ((@second.mileage - @first.mileage)/@second.gallons).round(2)
    end
  end
end
