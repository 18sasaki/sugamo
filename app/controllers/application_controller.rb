class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def date_view(datetime)
  	datetime.strftime("%m/%d（#{%w(日 月 火 水 木 金 土)[Time.now.wday]}）")
  end
end
