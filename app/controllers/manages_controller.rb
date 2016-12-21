class ManagesController < ApplicationController
  def index
  end

	def create
  	Dairy.create_dairies(params[:year])

    redirect_to action: "index", notice: "#{params[:year]}年度のDairyを作成しました。"
  end
end
