require 'spec_helper'

describe Fillup do
  describe 'calculating mpgs' do
    before(:each) do
      @vehicle = Vehicle.make!
      @first = Fillup.make!(mileage: 100, gallons: 10, filled_at: Time.now - 5.minutes)
      @second = Fillup.make!(mileage: 120, gallons: 11, filled_at: Time.now - 3.minutes)
      @last = Fillup.make!(mileage: 150, gallons: 15)
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
      @last.mpg.should== ((@last.mileage.to_f - @second.mileage)/@last.gallons).round(2)
    end

    it 'should calculate the its own mpg on save when mileage is changed' do
      @new_mileage = 130
      @second.update_attribute(:mileage, @new_mileage)
      @second.reload
      @second.mpg.should== ((@second.mileage.to_f - @first.mileage)/@second.gallons).round(2)
    end
  end

  describe 'per_hundred' do
    it 'should be nil without an mpg' do
      @fillup = Fillup.make!(mpg: nil)
      @fillup.per_hundred.should be_nil
    end

    it 'should be nil without price per gallon' do
      @fillup = Fillup.make!(ppg: nil)
      @fillup.per_hundred.should be_nil
    end

    it 'should return with an mpg and ppg' do
      @mpg = 10
      @ppg = 10
      @fillup = Fillup.make!(mpg: @mpg, ppg: @ppg)
      @fillup.per_hundred.should== (100 / @mpg) * @ppg
    end
  end
end
