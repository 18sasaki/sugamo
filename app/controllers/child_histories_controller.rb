class ChildHistoriesController < ApplicationController
  def index
    @page_title = "園児変更履歴"
    @child_histories = ChildHistory.where.not(child_id: nil).includes(:child).order(:change_date)
  end

  def show
    @page_title = "#{date_view(params[:date].to_date)}時点の人数"
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
      # TODO: grade含めたlistにして、ｖｉｅｗで学年ごとに区切れたら嬉しい。
      @child_history_list = ChildHistory.where(change_date: params[:date].to_date)
    end
end
