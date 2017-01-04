class AbsentChild < ApplicationRecord
	belongs_to :dairy
	belongs_to :child

  validates :dairy_id, :class_room_id, :child_id, :absent_code, presence: true

	def self.find_by_date(date)
		AbsentChild.includes(:dairy).where(dairies: {date: date})
	end

	def self.get_by_date(date)
		AbsentChild.includes(:dairy, :child).where(dairies: {date: date})
	end
end
