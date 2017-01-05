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

	def self.get_by_child(child_id)
		AbsentChild.includes(:dairy).where(child_id: child_id).order('dairies.date desc')
	end

	def self.get_hash_by_class_rooms(class_room_id)
		count_hash = get_count({class_room_id: class_room_id}, [:child_id, :absent_code])
		# {[child_id, absent_code] => count, ...}
		count_hash.each_with_object({}) do |(key_list, count), result|
		  (result[key_list[0]] ||= {})[key_list[1]] = count
		end
	end

	def self.get_count(where_hash, group_list)
		AbsentChild.includes(:child)
		           .where(where_hash)
		           .group(group_list)
		           .count
	end
end
