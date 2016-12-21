class AbsentChild < ApplicationRecord
	belongs_to :dairy

	def self.find_by_date(date)
		AbsentChild.includes(:dairy).where(dairies: {date: date})
	end
end
