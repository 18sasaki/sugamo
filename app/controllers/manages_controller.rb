class ManagesController < ApplicationController
  def index
  end

	def create
  	notice_string = Dairy.bulk_create(params[:year])

    redirect_to action: "index", notice: notice_string
  end
end
