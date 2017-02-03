class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :date_view, :status_str, :sex_color, :toyeard, :date_to_ym

  def date_view(datetime = Date.today)
    datetime.strftime("%y/%m/%d（#{Constants::DOW[datetime.wday]}）")
  end

  def day_view(datetime = Date.today)
  	datetime.strftime('%d')
  end

  def status_str(status_code)
    status_code == 'enrollment' ? '' : "（#{Constants::ALL_CODES['child_status'][status_code][:view_name]}）"
  end

  def sex_color(sex_code)
  	sex_code == 'female' ? '#ff0000' : '#000000'
  end

  # TODO: 毎回計算しててイケてない。year_id導入で直るとうれしい。
  def toyeard
    today = Date.today
    year = today.year
    # 1/1～3/31の間なら、年度は１年前
    today.between?('0101'.to_date, '0331'.to_date) ? year - 1 : year
  end

  def ym_to_date(ym)
    "#{ym}01".to_date
  end

  def date_to_ym(date)
    date.strftime('%Y%m')
  end

  def today_id
    Dairy.find_by(date: Date.today).id
  end
end
