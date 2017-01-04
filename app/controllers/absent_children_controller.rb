class AbsentChildrenController < ApplicationController
  before_action :set_absent_child, only: [:show, :edit, :update, :destroy]

  def index
    @target_date = params[:date].try(:to_date) || Date.today
    @today = date_view(@target_date)
    @absent_children = AbsentChild.get_by_date(@target_date)
  end

  def show
  end

  def new
    @absent_child = AbsentChild.new
    @children_list = Child.get_list
  end

  def edit
    @children_list = Child.get_list
    # target_date = date_view(@absent_child.dairy.date)
    # target_name = @absent_child.child.full_name_f
    # target_class_room = @absent_child.class_room.short_name

    # @title_string = "#{target_date}の#{target_name}（#{target_class_room}）の情報を編集"
  end

  def create
    @absent_child = AbsentChild.new(absent_child_params)

    respond_to do |format|
      if @absent_child.save
        format.html { redirect_to absent_children_path(date: @target_date), notice: '登録に成功しました' }
        format.json { render :index, status: :ok }
      else
        @children_list = Child.get_list
        format.html { render :new }
        format.json { render json: @absent_child.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    respond_to do |format|
      if @absent_child.update(absent_child_params)
        format.html { redirect_to absent_children_path(date: @target_date), notice: '編集に成功しました' }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @absent_child.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @absent_child.destroy
    respond_to do |format|
      format.html { redirect_to absent_children_url, notice: 'Absent child was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_absent_child
      @absent_child = AbsentChild.find(params[:id])
    end

    def absent_child_params
      params[:absent_child][:dairy_id] = change_date_to_dairy_id(params[:dairy])
      params[:absent_child][:class_room_id] = set_class_room_id(params[:absent_child][:child_id])
      params.require(:absent_child).permit(:dairy_id, :class_room_id, :child_id, :absent_code, :reason_code, :reason_text)
    end

    def change_date_to_dairy_id(date_params)
      @target_date = (date_params['date(1i)'] + sprintf("%02d", date_params['date(2i)']) + sprintf("%02d", date_params['date(3i)'])).to_date
      Dairy.find_by(date: @target_date).id
    end

    def set_class_room_id(child_id)
      Child.find_by(id: child_id).try(:class_room_id)
    end
end
