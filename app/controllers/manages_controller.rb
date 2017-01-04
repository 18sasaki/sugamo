class ManagesController < ApplicationController
  def index
    @page_title = '管理画面'
  	# 初期設定系はいずれ実装する為の備忘用メソッド。
  	# ワンクリックで済ませるかもしれないので、その場合は不要かも。
    # dairy_present_flg = dairy_has_created?

    # cr_history
    # ４月１日時点のものがなければ、最初のcreateはそれ。
    # 続いて５月１日時点のもの。
    # いずれも存在すれば、以降はchildrenの変更タイミングで自動生成されるのみ。
    # っていうチェックする。
    # やっぱやめ。
    # 4/1と5/1時点のcr_history見るリンク張って、存在しなければ（その時点の日付見て）作る。
  end


	def dairy_create
  	notice_string = Dairy.bulk_create(params[:year])

    redirect_to action: "index", notice: notice_string
  end

  private
  # def dairy_has_created?
  # 	Dairy.find_by(date: "#{Date.today.year}0401".to_date)
  # end
end
