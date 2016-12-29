module ChildrenHelper
  def sex_list
  	Constants::ALL_CODES['sex'].each_with_object([]) do |rea_hash, ret_list|
  		ret_list << [rea_hash[1][:view_name], rea_hash[0]]
  	end
  end

  def status_str(code)
  	if code == 'enrollment'
      ''
    else
      "（#{Constants::ALL_CODES['child_status'][code][:view_name]}）"
    end
  end
end
