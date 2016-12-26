class ClassRoomsController < ApplicationController
  def index
    @class_rooms = ClassRoom.all
  end

  def edit
    @class_room = ClassRoom.find(params[:id])
  end

  def update
    respond_to do |format|
      @class_room = ClassRoom.find(params[:id])
      if @class_room.update(class_room_params)
        format.html { redirect_to :class_rooms, notice: "#{@class_room.name}組を更新しました。" }
        format.json { render :index, status: :ok }
      else
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
