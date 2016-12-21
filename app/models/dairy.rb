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
			Dairy.new(date: one_day,
				        dow:  Constants::DOW[one_day.wday],
				        dairy_code: one_day.wday.between?(1, 5) ? 'undec' : 'holid').save
		end
	end
end
