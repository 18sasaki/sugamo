class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :date_view, :birthday_view, :birthday_view_with_y, :status_str, :sex_color, :toyeard, :date_to_ym

  def date_view(datetime = Date.today)
    datetime.strftime("%y/%m/%d（#{Constants::DOW[datetime.wday]}）")
  end

  def birthday_view(birthday, y_flg = false)
    if birthday
      if y_flg
        birthday.strftime("%Y/%m/%d")
      else
        birthday.strftime("%m/%d")
      end
    else
      '未設定'
    end
  end

  def birthday_view_with_y(birthday)
    birthday_view(birthday, true)
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

  # Constantsに入れてみた
  # # TODO: 毎回計算しててイケてない。year_id導入で直るとうれしい。
  # def toyeard
  #   today = Date.today
  #   year = today.year
  #   # 1/1～3/31の間なら、年度は１年前
  #   today.between?('0101'.to_date, '0331'.to_date) ? year - 1 : year
  # end

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
