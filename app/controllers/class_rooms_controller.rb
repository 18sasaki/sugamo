class ClassRoomsController < ApplicationController
  def index
    @page_title = 'クラス'
    @class_rooms = ClassRoom.all
  end

  def show
    @class_room = ClassRoom.find(params[:id])
    @page_title = @class_room.name
    @page_title_bg_color = Constants::CR_HASH[@class_room.id][:color]

    @children = Child.where(class_room_id: params[:id]).order(sex_code: 'desc', full_name_f: 'asc')

    jb_ch = ChildHistory.get_jb_ch(params[:id], Date.today)
    @count_str = "#{jb_ch.total_count}人（ 男：#{jb_ch.total_m_count}人 女：#{jb_ch.total_f_count}人）"

    @child_history_data = ChildHistory.get_ch_data(params[:id])
  end

  def edit
    @class_room = ClassRoom.find(params[:id])
    @page_title = "#{@class_room.name}組 編集"
  end

  def update
    respond_to do |format|
      @class_room = ClassRoom.find(params[:id])
      if @class_room.update(class_room_params)
        format.html { redirect_to :class_rooms, notice: "#{@class_room.name}組を更新しました。" }
        format.json { render :index, status: :ok }
      else
        @page_title = "#{@class_room.name}組 編集"
        format.html { render :edit }
        format.json { render json: @class_room.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def class_room_params
      params.require(:class_room).permit(:grade_code, :name, :short_name, :color, :teacher_name, :sub_teacher_name)
    end
end
