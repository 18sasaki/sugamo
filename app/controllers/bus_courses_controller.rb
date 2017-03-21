class BusCoursesController < ApplicationController
  before_action :set_bus_course, only: [:show, :edit, :update, :destroy]

  def index
    @page_title = "バスコース"
    @bus_courses = BusCourse.all
  end

  def show
    @page_title = "#{@bus_course.bus.name}#{@bus_course.number}#{@bus_course.color_name}コース"
    @page_title_bg_color = "##{@bus_course.color}"

    @bus_stop_list = BusStop.where(bus_course_id: params[:id])
    @main_used_children_hash = Child.includes(:main_bus_stop)
                                    .includes(:class_room)
                                    .where('bus_stops.bus_course_id': params[:id])
                                    .each_with_object({}) do |child, re|
                                      (re[child.main_bus_stop_id] ||= []) << [child, child.class_room.short_name]
                                    end
    @sub_used_children_hash = Child.includes(:sub_bus_stop)
                                   .includes(:class_room)
                                   .where('bus_stops.bus_course_id': params[:id])
                                   .each_with_object({}) do |child, re|
                                     (re[child.sub_bus_stop_id] ||= []) << [child, child.class_room.short_name]
                                   end
  end

  def new
    @page_title = "バスコース作成"
    @bus_course = BusCourse.new
    @buses = Bus.all.pluck(:name, :id)
    # デフォルトで10か所
    10.times { @bus_course.bus_stops.build }
  end

  def edit
    @page_title = "バスコース編集"
    @buses = Bus.all.pluck(:name, :id)
    (10 - @bus_course.bus_stops.count).times { @bus_course.bus_stops.build }
  end

  def create
    @bus_course = BusCourse.new(bus_course_params)

    respond_to do |format|
      if @bus_course.save
        format.html { redirect_to bus_courses_path, notice: '登録に成功しました' }
        format.json { render :index, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @bus_course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bus_course.update(bus_course_params)
        format.html { redirect_to bus_courses_path, notice: '更新しました' }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @bus_course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bus_course.destroy
    respond_to do |format|
      format.html { redirect_to bus_courses_url, notice: 'Bus course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_bus_course
      @bus_course = BusCourse.find(params[:id])
    end

    def bus_course_params
      params.require(:bus_course)
            .permit(:bus_id, 
                    :number, 
                    :color_name, 
                    :color, 
                    :a_departure_time, 
                    :a_arrival_time, 
                    :b_departure_time, 
                    :b_arrival_time, 
                    :c_departure_time, 
                    :c_arrival_time,
                    bus_stops_attributes: [:id,
                                           :name,
                                           :name_k,
                                           :view_name,
                                           :number,
                                           :a_arrival_time, 
                                           :b_arrival_time, 
                                           :c_arrival_time,
                                           :_destroy
                                          ])
    end
end
