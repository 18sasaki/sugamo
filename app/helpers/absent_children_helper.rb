module AbsentChildrenHelper
  def absent_list
  	Constants::ALL_CODES['absent'].each_with_object([]) do |abs_hash, ret_list|
  		ret_list << [abs_hash[1][:view_name], abs_hash[0]]
  	end
  end

  def absent_view_name(code_key)
  	Constants::ALL_CODES['absent'][code_key][:view_name]
  end

  def reason_list
  	Constants::ALL_CODES['reason'].each_with_object([]) do |rea_hash, ret_list|
  		ret_list << [rea_hash[1][:view_name], rea_hash[0]]
  	end
  end

  def reason_view_name(code_key)
  	Constants::ALL_CODES['reason'][code_key].try([:view_name]) || '理由不明'
  end
end
