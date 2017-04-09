class ChangeColumnsToBusStops < ActiveRecord::Migration[5.0]
  def change
  	change_column(:bus_stops, :a_arrival_time, :string)
  	change_column(:bus_stops, :b_arrival_time, :string)
  	change_column(:bus_stops, :c_arrival_time, :string)
  end
end
