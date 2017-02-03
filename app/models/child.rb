class Child < ApplicationRecord
  validates :unique_num, :class_room_id, :post_number, :address, :full_name, :full_name_f, :sex_code, presence: true

	def self.get_list(option = {})
		children = option.present? ? Child.where(option) : Child.all

		children.order('full_name_f').inject [] do |ret, child|
			ret << [child.full_name_f, child.id]
		end
	end
end
