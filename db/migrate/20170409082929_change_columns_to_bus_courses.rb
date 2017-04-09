class ChangeColumnsToBusCourses < ActiveRecord::Migration[5.0]
  def change
  	change_column(:bus_courses, :a_departure_time, :string)
  	change_column(:bus_courses, :a_arrival_time, :string)
  	change_column(:bus_courses, :b_departure_time, :string)
  	change_column(:bus_courses, :b_arrival_time, :string)
  	change_column(:bus_courses, :c_departure_time, :string)
  	change_column(:bus_courses, :c_arrival_time, :string)
  end
end
