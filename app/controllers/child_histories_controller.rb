class ChildHistoriesController < ApplicationController
  def index
    @child_histories = ChildHistory.where.not(child_id: nil).includes(:child).order(:change_date)
  end

  def show
  	# listとかに名前変えたい
    # TODO: 学年ごとまとめたい。
  	# 存在しなければ作成する
  	if set_child_history.blank?
  		if params[:date].slice(4,4) == '0401' || '0501'
  		  ChildHistory.set(params[:date].to_date)
        set_child_history
  		end
  	end
  end

  private
    def set_child_history
    	# TODO: ありえない日が指定されたらredirectかける
      @child_history_list = ChildHistory.where(change_date: params[:date].to_date)
    end
end
