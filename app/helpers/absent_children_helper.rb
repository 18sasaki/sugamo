module AbsentChildrenHelper
  def absent_view_name(code_key)
  	Code.find_by(code_type: 'absent', code_key: code_key).view_name
  end

  def reason_view_name(code_key)
  	Code.find_by(code_type: 'reason', code_key: code_key).try(:view_name) || '理由不明'
  end
end
