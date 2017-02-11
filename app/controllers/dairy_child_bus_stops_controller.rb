class DairyChildBusStopsController < ApplicationController
  before_action :set_dairy_child_bus_stop, only: [:show, :edit, :update, :destroy]

  # GET /dairy_child_bus_stops
  # GET /dairy_child_bus_stops.json
  def index
    @dairy_child_bus_stops = DairyChildBusStop.all
  end

  # GET /dairy_child_bus_stops/1
  # GET /dairy_child_bus_stops/1.json
  def show
  end

  # GET /dairy_child_bus_stops/new
  def new
    @dairy_child_bus_stop = DairyChildBusStop.new
  end

  # GET /dairy_child_bus_stops/1/edit
  def edit
  end

  # POST /dairy_child_bus_stops
  # POST /dairy_child_bus_stops.json
  def create
    @dairy_child_bus_stop = DairyChildBusStop.new(dairy_child_bus_stop_params)

    respond_to do |format|
      if @dairy_child_bus_stop.save
        format.html { redirect_to @dairy_child_bus_stop, notice: 'Dairy child bus stop was successfully created.' }
        format.json { render :show, status: :created, location: @dairy_child_bus_stop }
      else
        format.html { render :new }
        format.json { render json: @dairy_child_bus_stop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dairy_child_bus_stops/1
  # PATCH/PUT /dairy_child_bus_stops/1.json
  def update
    respond_to do |format|
      if @dairy_child_bus_stop.update(dairy_child_bus_stop_params)
        format.html { redirect_to @dairy_child_bus_stop, notice: 'Dairy child bus stop was successfully updated.' }
        format.json { render :show, status: :ok, location: @dairy_child_bus_stop }
      else
        format.html { render :edit }
        format.json { render json: @dairy_child_bus_stop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dairy_child_bus_stops/1
  # DELETE /dairy_child_bus_stops/1.json
  def destroy
    @dairy_child_bus_stop.destroy
    respond_to do |format|
      format.html { redirect_to dairy_child_bus_stops_url, notice: 'Dairy child bus stop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dairy_child_bus_stop
      @dairy_child_bus_stop = DairyChildBusStop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dairy_child_bus_stop_params
      params.require(:dairy_child_bus_stop).permit(:dairy_id, :child_id, :bus_stop_id, :reason_text, :dcb_code, :unuse_flg, :pick_up_no, :fare_code)
    end
end
