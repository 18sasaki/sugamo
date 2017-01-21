class ChildHistory < ApplicationRecord
	belongs_to :child
	belongs_to :dairy

  validates :class_room_id, :total_m_count, :total_f_count, :total_count, :history_code, presence: true

	def self.set(date)
		# 4/1と5/1にやる前提で、その時点のchildrenで作っちゃう作戦。
		# TODO: 起こりうる齟齬洗い出して対策とる
		hhh = Child.group(:class_room_id).group(:sex_code).count
		dairy_id = Dairy.find(date: date).id

    ch_params = {}
		hhh.each do |key, value|
			ch_params[key[0]] ||= { dairy_id:      dairy_id,
						                  class_room_id: key[0],
						                  total_count:   0,
						                  history_code:  'regular' }
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

	def self.create(child, history_code, dairy_id, change_type)
		# 該当classroomで該当日の直前のデータに変更を加えてcreateする。
		# just_before_child_history
		jb_ch = get_jb_ch(child.class_room_id, dairy_id)

    count_hash = change_count_hash(jb_ch, change_type, child.sex_code)
    	
		ChildHistory.new( dairy_id:      dairy_id,
			                class_room_id: child.class_room_id,
			                child_id:      child.id,
			                total_m_count: count_hash[:total_m_count],
			                total_f_count: count_hash[:total_f_count],
			                total_count:   count_hash[:total_count],
			                history_code:  history_code ).save

		# 該当classroomで該当日の後のデータに変更を加えてupdateする。
		# ただしchange_typeが'ｋｅｅｐ'の場合は変更なし。
		if change_type != 'keep' # 'inc' or 'dec'
			aft_chs = ChildHistory.where(class_room_id: child.class_room_id).where('dairy_id > ?', dairy_id)
			aft_chs.each do |aft_ch|
				aft_ch.update(change_count_hash(aft_ch, change_type, child.sex_code))
			end
		end
	end

	def self.get_ch_data(class_room_id)
		ChildHistory.where(class_room_id: class_room_id)
		            .where.not(child_id: nil)
		            .includes(:child)
		            .includes(:dairy)
		            .order(dairy_id: 'desc', id: 'desc')
		            .pluck(:'dairy.date', :full_name_f, :sex_code, :history_code, :total_count, :total_m_count, :total_f_count, :"child_histories.id")
	end

	def self.get_jb_ch(class_room_id, dairy_id)
		ChildHistory.where(class_room_id: class_room_id)
		            .where('dairy_id <= ?', dairy_id)
		            .order(dairy_id: 'desc', id: 'desc')
		            .first
	end

	def self.get_count_hash(class_room_id, target_date)
		get_jb_ch(class_room_id, target_date)
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
    when 'keep'     then { total_m_count: m_count,      total_f_count: f_count,      total_count: t_count      }
  	else                 { total_m_count: m_count,      total_f_count: f_count,      total_count: t_count      } # ないはず
    end
	end
end
