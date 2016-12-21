class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def date_view(datetime)
  	datetime.strftime("%m/%d（#{Constants::DOW[Time.now.wday]}）")
  end
end
