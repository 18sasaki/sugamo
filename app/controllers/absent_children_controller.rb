class AbsentChildrenController < ApplicationController
  before_action :set_absent_child, only: [:show, :edit, :update, :destroy]

  def index
    @target_date = params[:date].try(:to_date) || Date.today
    @today = date_view(@target_date)
    @absent_children = AbsentChild.find_by_date(@target_date)
  end

  def show
  end

  def new
    @absent_child = AbsentChild.new
  end

  def edit
    # target_date = date_view(@absent_child.dairy.date)
    # target_name = @absent_child.child.full_name_f
    # target_class_room = @absent_child.class_room.short_name

    # @title_string = "#{target_date}の#{target_name}（#{target_class_room}）の情報を編集"
  end

  def create
    @absent_child = AbsentChild.new(absent_child_params)

    respond_to do |format|
      if @absent_child.save
        format.html { redirect_to @absent_child, notice: 'Absent child was successfully created.' }
        format.json { render :show, status: :created, location: @absent_child }
      else
        format.html { render :new }
        format.json { render json: @absent_child.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @absent_child.update(absent_child_params)
        format.html { redirect_to @absent_child, notice: 'Absent child was successfully updated.' }
        format.json { render :show, status: :ok, location: @absent_child }
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
      params.require(:absent_child).permit(:dairy_id, :class_room_id, :child_id, :absent_code, :reason_code, :reason_text)
    end

    def change_date_to_dairy_id(date_params)
      target_date = (date_params['date(1i)'] + date_params['date(2i)'] + date_params['date(3i)']).to_date
      Dairy.find_by(date: target_date).id
    end
end
