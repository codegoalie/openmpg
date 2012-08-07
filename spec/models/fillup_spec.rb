require 'spec_helper'

describe Fillup do
  describe 'calculating mpgs' do
    before(:each) do
      @vehicle = Vehicle.make!
      @first =  Fillup.make!(filled_at: Time.now - 5.minutes, mileage: 100, gallons: 10)
      @last =  Fillup.make!(filled_at: Time.now, mileage: 150, gallons: 11)
      @vehicle.fillups << @first << @last
      @new_gallons = 15
      @new_milgeage = 200
    end

    it 'should calculate the previous fillups mpg on save when gallons are changed' do
      @last.update_attribute(:gallons, @new_gallons)
      @last.mpg.should== (@last.mileage - @first.mileage)/@new_gallons
    end

    it 'should calculate the previous fillups mpg on save when mileage is changed' do
      @last.update_attribute(:mileage, @new_milege)
      @last.mpg.should== (@new_mileage - @first.mileage)/@last.gallons
    end

    it 'should calculate the its own mpg on save when mileage is changed' do
      @first.update_attribute(:mileage, @new_milege)
      @first.mpg.should== (@last.mileage - @new_mileage)/@last.gallons
    end
  end
end
