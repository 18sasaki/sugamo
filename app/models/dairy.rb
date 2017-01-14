class Dairy < ApplicationRecord
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

	def self.get_by_ym(yeard, month)
		year = (month.to_i).between?(1, 3) ? yeard.to_i + 1 : yeard
		Dairy.where(date: "#{year}#{sprintf("%02d",month)}01" .. "#{year}#{sprintf("%02d",month)}31")
	end

	# def self.bulk_update(params_hash)
	# 	params_hash.each do |id, params|
	# 		target_dairy = Dairy.find(id)
	# 		target_dairy.dairy_code = params[:dairy_code]
	# 		target_dairy.save!
	# 	end
	# end

	def self.bulk_update(params_hash, auto_flg = false)
		params_hash.each do |id, params|
			target_dairy = Dairy.find(id)
			target_dairy_code = target_dairy.dairy_code
			# 変更なしの場合auto対象かチェック
			if target_dairy_code == params[:dairy_code]
				# autoモードなら「未定」を「平常保育」にする
				if auto_flg && target_dairy_code == 'undec'
					target_dairy.dairy_code = 'full'
				# 「未定」でなければ無視して次
				else
					next
				end
			# 変更があればそちら優先
			else
				target_dairy.dairy_code = params[:dairy_code]
			end
			target_dairy.save!
		end
	end

	def self.bulk_update_auto(params_hash)
		min, max = params_hash.keys.minmax
		Dairy.where(id: [min..max]).where(dairy_code: 'undec').update_all(dairy_code: 'full')
	end
end
