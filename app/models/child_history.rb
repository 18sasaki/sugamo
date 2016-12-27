class ChildHistory < ApplicationRecord
	belongs_to :child

	def self.set(date)
		# 4/1と5/1にやる前提で、その時点のchildrenで作っちゃう作戦。
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

	def self.create(child, change_type, change_date)
		# 該当classroomで該当日の直前のデータに変更を加えてcreateする。
		# just_before_child_history
		jb_ch = ChildHistory.where(class_room_id: child.class_room_id).where('change_date <= ?', change_date).last

    # # countの計算
    # new_total_count   = jb_ch.total_count
    # new_total_f_count = jb_ch.total_f_count
    # new_total_m_count = jb_ch.total_m_count
    # if change_type == 'inc'
    # 	new_total_count += 1
	   #  if child.sex_code == 'female'
	   #  	new_total_f_count += 1
    # 	else
    # 		new_total_m_count += 1
    # 	end
    # else
    # 	new_total_count -= 1
	   #  if child.sex_code == 'female'
	   #  	new_total_f_count -= 1
    # 	else
    # 		new_total_m_count -= 1
    # 	end
    # end

    count_hash = change_count_hash(jb_ch, change_type, child.sex_code)
    	
		ChildHistory.new( change_date:   change_date,
			                class_room_id: child.class_room_id,
			                child_id:      child.id,
			                total_m_count: count_hash[:total_m_count],
			                total_f_count: count_hash[:total_f_count],
			                total_count:   count_hash[:total_count],
			                change_code:   child.history_code ).save

		# 該当classroomで該当日の後のデータはすべて変更を加えてupdateする。
		aft_chs = ChildHistory.where(class_room_id: child.class_room_id).where('change_date > ?', change_date)
		aft_chs.each do |aft_ch|
			aft_ch.update(change_count_hash(aft_ch, change_type, child.sex_code))
		end
	end

	private
	def self.change_count_hash(target_ch, change_type, sex_code)
		m_count = target_ch.total_m_count
		f_count = target_ch.total_f_count
		t_count = target_ch.total_count

    case change_type
    when 'inc'
    	case sex_code
    	when 'female' then { total_m_count: m_count,      total_f_count: f_count += 1, total_count: t_count += 1 }
    	when 'male'   then { total_m_count: m_count += 1, total_f_count: f_count,      total_count: t_count += 1 }
    	else               { total_m_count: m_count,      total_f_count: f_count,      total_count: t_count      } # ないはず
    	end
    when 'dec'
    	case sex_code
    	when 'female' then { total_m_count: m_count,      total_f_count: f_count -= 1, total_count: t_count -= 1 }
    	when 'male'   then { total_m_count: m_count -= 1, total_f_count: f_count,      total_count: t_count -= 1 }
    	else               { total_m_count: m_count,      total_f_count: f_count,      total_count: t_count      } # ないはず
    	end
  	else                 { total_m_count: m_count,      total_f_count: f_count,      total_count: t_count      } # ないはず
    end

    # if change_type == 'inc'
    # 	t_count += 1
	   #  if sex_code == 'female'
	   #  	f_count += 1
    # 	else # 'male'
    # 		m_count += 1
    # 	end
    # else # 'dec'
    # 	t_count -= 1
	   #  if sex_code == 'female'
	   #  	f_count -= 1
    # 	else # 'male'
    # 		m_count -= 1
    # 	end
    # end

    # { m_count: m_count, f_count: f_count, t_count: t_count }
	end
end
