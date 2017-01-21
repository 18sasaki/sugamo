class Dairy < ApplicationRecord
	has_many :absent_children
	has_many :child_histories

  # dairyは必ず日付順であること！！！

	def self.bulk_create(year)
		if Dairy.find_by(date: "#{year}0401".to_date)
			"#{year}年度のDairyはすでに作成済みです。"
		else
			create_dairies(year)
			"#{year}年度のDairyを作成しました。"
		end
	end

	def self.create_dairies(year)
		("#{year}0401".to_date .. "#{year.to_i + 1}0331".to_date).each do |one_day|
			att_flg = one_day.wday.between?(1, 5)
			Dairy.new(date:         one_day,
				        dow:          Constants::DOW[one_day.wday],
				        att_shou_flg: att_flg ? 1 : 0,
				        att_chuu_flg: att_flg ? 1 : 0,
				        att_chou_flg: att_flg ? 1 : 0,
				        dairy_code:   att_flg ? 'undec' : 'holiday').save
		end
	end

	def self.get_by_date(date)
		Dairy.where(date: date)
	end

	def self.get_by_todate(todate)
		Dairy.where(date: todate ... todate.next_month)
	end

	def self.bulk_update(params_hash)
		params_hash.each do |id, params|
			target_dairy = Dairy.find(id)
			# 変更があった場合のみ更新
			unless target_dairy.dairy_code == params[:dairy_code]
				target_dairy.dairy_code = params[:dairy_code]
				target_dairy.save!
			end
		end
	end
end
