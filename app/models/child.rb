class Child < ApplicationRecord
	def self.get_list
		Child.all.order('full_name_f').inject [] do |ret, child|
			ret << [child.full_name_f, child.id]
		end
	end
end
