class BusCoursesController < ApplicationController
  before_action :set_bus_course, only: [:show, :edit, :update, :destroy]

  # GET /bus_courses
  # GET /bus_courses.json
  def index
    @page_title = "バスコース"
    @bus_courses = BusCourse.all
  end

  # GET /bus_courses/1
  # GET /bus_courses/1.json
  def show
  end

  # GET /bus_courses/new
  def new
    @page_title = "バスコース作成"
    @bus_course = BusCourse.new
    @buses = Bus.all.pluck(:name, :id)
    # @bus_course.bus_stops.build
    10.times { @bus_course.bus_stops.build }
  end

  # GET /bus_courses/1/edit
  def edit
    @page_title = "バスコース編集"
    @buses = Bus.all.pluck(:name, :id)
    # @bus_stops = BusStop.where(bus_course_id: @bus_course.id).order(:number)
  end

  # POST /bus_courses
  # POST /bus_courses.json
  def create
    @bus_course = BusCourse.new(bus_course_params)

p "--------------------------"
p params
p "--------------------------"
p bus_course_params
p "--------------------------"

    # binding.pry

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

  # PATCH/PUT /bus_courses/1
  # PATCH/PUT /bus_courses/1.json
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

  # DELETE /bus_courses/1
  # DELETE /bus_courses/1.json
  def destroy
    @bus_course.destroy
    respond_to do |format|
      format.html { redirect_to bus_courses_url, notice: 'Bus course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus_course
      @bus_course = BusCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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
