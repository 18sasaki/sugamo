class ChildHistory < ApplicationRecord
	def self.set(date)
		# クラスをeachして、dateの直前のchild_historyそのままに日付をdateで複製する。
		# 基本的には4/1と5/1でしか使わない。
		# Constants::CR_LIST : [[cr.name, cr.id],[cr.name, cr.id],...]
		# Constants::CR_LIST.each do |cr_list|
		# 	cr_id = cr_list[1]
		# 	Child.find_by(cr_id).count
		# end

		# ではなく、4/1と5/1にやる前提で、その時点のchildrenで作っちゃう作戦。
		# TODO: 起こりうる齟齬洗い出して対策とる
		hhh = Child.group(:class_room_id).group(:sex_code).count
    ch_params = {}
		hhh.each do |key, value|
			ch_params[key[0]] ||= { change_date:   date,
						                  class_room_id: key[0],
						                  total_count:   0,
						                  change_code:   'regular' }
			case key[1]
			when 'female'
				ch_params[key[0]][:total_f_count] = value
			when 'male'
				ch_params[key[0]][:total_m_count] = value
			end
			ch_params[key[0]][:total_count] += value
		end

		ch_params.each do |cr_id, params|
			ChildHistory.new(params).save
		end
	end

	def self.create(params)
		# childの変更によって人数変動が生じたら作成する。
	end
end
