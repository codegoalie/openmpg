class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_timezone

  def set_current_timezone
     Time.zone = current_user && current_user.time_zone && current_user.time_zone.present? ? 
       current_user.time_zone : 
       ActiveSupport::TimeZone[-cookies[:timezone].to_i.minutes]
  end

rescue_from CanCan::AccessDenied do |exception|
  redirect_to root_url, :alert => exception.message
end
end
