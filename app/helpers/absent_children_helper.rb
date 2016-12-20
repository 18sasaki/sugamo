module AbsentChildrenHelper
  def absent_view_name(code_key)
  	Constants::ALL_CODES['absent'][code_key][:view_name]
  end

  def reason_view_name(code_key)
  	Constants::ALL_CODES['reason'][code_key].try([:view_name]) || '理由不明'
  end
end
