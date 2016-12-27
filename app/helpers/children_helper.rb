module ChildrenHelper
  def sex_list
  	Constants::ALL_CODES['sex'].each_with_object([]) do |rea_hash, ret_list|
  		ret_list << [rea_hash[1][:view_name], rea_hash[0]]
  	end
  end

  def status_str(code)
  	if code == 'inc'
      ''
    else
      "（#{Constants::ALL_CODES['history'][code][:view_name]}）"
    end
  end
end
