module ApplicationHelper
  def date_view(datetime)
  	datetime.strftime("%m/%d（#{Constants::DOW[datetime.wday]}）")
  end
end
