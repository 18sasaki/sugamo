class BusCoursesController < ApplicationController
  before_action :set_bus_course, only: [:show, :edit, :update, :destroy]

  # GET /bus_courses
  # GET /bus_courses.json
  def index
    @bus_courses = BusCourse.all
  end

  # GET /bus_courses/1
  # GET /bus_courses/1.json
  def show
  end

  # GET /bus_courses/new
  def new
    @bus_course = BusCourse.new
  end

  # GET /bus_courses/1/edit
  def edit
  end

  # POST /bus_courses
  # POST /bus_courses.json
  def create
    @bus_course = BusCourse.new(bus_course_params)

    respond_to do |format|
      if @bus_course.save
        format.html { redirect_to @bus_course, notice: 'Bus course was successfully created.' }
        format.json { render :show, status: :created, location: @bus_course }
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
        format.html { redirect_to @bus_course, notice: 'Bus course was successfully updated.' }
        format.json { render :show, status: :ok, location: @bus_course }
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
      params.require(:bus_course).permit(:bus_id, :number, :color_name, :color, :1_departure_time, :1_arrival_time, :2_departure_time, :2_arrival_time, :3_departure_time, :3_arrival_time)
    end
end
