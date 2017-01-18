class DairiesController < ApplicationController
  def index
  	@page_title = "Dairy管理画面"
  	@todate = ym_to_date(params[:ym])
  	@dairies = Dairy.get_by_todate(@todate)
  end

  def bulk_update
    respond_to do |format|
    	if Dairy.bulk_update(params[:dairy])
	      format.html { redirect_to "/dairies?ym=#{params[:ym]}" , notice: '更新しました' }
	      format.json { render :index }
	    else
	      format.html { redirect_to "/dairies?ym=#{params[:ym]}" , notice: "更新できませんでした/#{e}" }
	      format.json { render json: 'errors', status: :unprocessable_entity }
	    end
	  end
  end
end
