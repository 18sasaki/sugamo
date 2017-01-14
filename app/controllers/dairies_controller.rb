class DairiesController < ApplicationController
  def index
  	@page_title = "Dairy管理画面"
  	month_i = params[:month].to_i
  	case month_i
  	when 1
  		@last_month = 12
  		@next_month = 2
  	when 12
  		@last_month = 11
  		@next_month = 1
  	else
  		@last_month = month_i - 1
  		@next_month = month_i + 1
  	end

  	@dairies = Dairy.get_by_ym(toyear, params[:month])
  	@blank_td_count = @dairies.first.date.wday
  	@first_id, @last_id = @dairies.pluck(:id).minmax
  	@dairy = Dairy.new
  end

  def bulk_update
    respond_to do |format|
    	if Dairy.bulk_update(params[:dairy])
	      format.html { redirect_to "/dairies?month=#{params[:month]}" , notice: '更新しました' }
	      format.json { render :index }
	    else
	      format.html { redirect_to "/dairies?month=#{params[:month]}" , notice: "更新できませんでした/#{e}" }
	      format.json { render json: 'errors', status: :unprocessable_entity }
	    end
	  end
  end
end
