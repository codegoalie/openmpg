class Vehicle < ActiveRecord::Base
  belongs_to :user
  has_many :fillups
  
  attr_accessible :color, :make, :model, :year, :nickname

  validates_presence_of  :color, :make, :model, :year, :nickname
  validates_uniqueness_of :nickname, scope: :user_id

  def to_s
    nickname
  end
end
