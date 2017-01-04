class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :date_view, :status_str, :sex_color

  def date_view(datetime)
  	datetime.strftime("%m/%d（#{Constants::DOW[datetime.wday]}）")
  end

  def status_str(status_code)
    status_code == 'enrollment' ? '' : "（#{Constants::ALL_CODES['child_status'][status_code][:view_name]}）"
  end

  def sex_color(sex_code)
  	sex_code == 'female' ? '#ff0000' : '#000000'
  end
end
