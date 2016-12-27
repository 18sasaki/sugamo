module ChildHistoriesHelper
  def history_view_name(code_key)
  	Constants::ALL_CODES['history'][code_key].view_name
  end
end
