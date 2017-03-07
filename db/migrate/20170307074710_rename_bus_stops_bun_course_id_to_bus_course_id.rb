class RenameBusStopsBunCourseIdToBusCourseId < ActiveRecord::Migration[5.0]
  def change
  	rename_column :bus_stops, :bun_course_id, :bus_course_id
  end
end
