class AbsentChildrenController < ApplicationController
  before_action :set_absent_child, only: [:show, :edit, :update, :destroy]

  def index
    @target_date = params[:date].try(:to_date) || Date.today
    @today = date_view(@target_date)
    @page_title = "#{@today}の欠席情報"
    @absent_children = AbsentChild.get_by_date(@target_date)
  end

  def show
  end

  def new
    @page_title = "欠席情報登録"
    @absent_child = AbsentChild.new
    if params[:child_id]
      @child_name = Child.find(params[:child_id]).full_name_f
    elsif params[:class_room_id]
      @children_list = Child.get_list(class_room_id: params[:class_room_id])
    else
      @children_list = Child.get_list
    end
  end

  def edit
    @page_title = "欠席情報編集（#{date_view(@absent_child.dairy.date)}　#{@absent_child.child.full_name_f}）"
    @child_name = Child.find(@absent_child.child_id).full_name_f
    # @children_list = Child.get_list
    # target_date = date_view(@absent_child.dairy.date)
    # target_name = @absent_child.child.full_name_f
    # target_class_room = @absent_child.class_room.short_name

    # @title_string = "#{target_date}の#{target_name}（#{target_class_room}）の情報を編集"
  end

  def create
    absent_child_params = set_absent_child_params
    @absent_child = AbsentChild.new(absent_child_params)

    respond_to do |format|
      if not_duplicate?(absent_child_params) && @absent_child.save
        format.html { redirect_to params[:back_to] || dairies_path(date: @target_date), notice: '登録に成功しました' }
        format.json { render "/#{@target_date}", status: :ok }
      else
        @page_title = "欠席情報登録"
        @children_list = Child.get_list
        flash[:error] = @error
        format.html { render :new }
        format.json { render json: @absent_child.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @absent_child.update(set_absent_child_params)
        format.html { redirect_to params[:back_to] || absent_children_path(date: @target_date), notice: '編集に成功しました' }
        format.json { render :index, status: :ok }
      else
        @page_title = "欠席情報編集（#{date_view(@absent_child.dairy.date)}　#{@absent_child.child.full_name_f}）"
        @children_list = Child.get_list
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

    def set_absent_child_params
      params[:absent_child][:dairy_id] = change_date_to_dairy_id(params[:dairy])
      params[:absent_child][:class_room_id] = set_class_room_id(params[:absent_child][:child_id])
      params.require(:absent_child).permit(:dairy_id, :class_room_id, :child_id, :absent_code, :reason_code, :reason_text)
    end

    def change_date_to_dairy_id(date_params)
      @target_date = (date_params['date(1i)'] + format("%02d", date_params['date(2i)']) + format("%02d", date_params['date(3i)'])).to_date
      Dairy.find_by(date: @target_date).id
    end

    def set_class_room_id(child_id)
      Child.find_by(id: child_id).try(:class_room_id)
    end

    def not_duplicate?(absent_child_params)
      if AbsentChild.where(dairy_id: absent_child_params[:dairy_id], child_id: absent_child_params[:child_id]).exists?
        @error = '同一日にすでに欠席情報が登録されています。'
        false
      else
        true
      end
    end
end
