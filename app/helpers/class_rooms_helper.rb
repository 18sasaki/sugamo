module ClassRoomsHelper
	def absent_count_check(absent_count_hash)
		score = 0
		Constants::ALL_CODES['absent'].each do |code, data|
      if absent_count_hash[code]
				case data[:check_string]
				when 'full'
	      	score += absent_count_hash[code]
				when 'half'
	      	score += absent_count_hash[code] * 0.5
	      end
	    end
		end

		case score
		when 0      # 皆勤
			# '#d2ff00'
			'rgba(210,255,0,0.5)'
		when 0.5..3 # 精勤
			# '#1EF2E7'
			'rgba(30,242,231,0.5)'
		end
	end
end
