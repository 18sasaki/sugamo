class CreateBusCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :bus_courses do |t|
      t.integer :bus_id,     :null => false
      t.integer :number,     :null => false
      t.string  :color_name, :null => false
      t.string  :color,      :null => false
      t.time    :a_departure_time
      t.time    :a_arrival_time
      t.time    :b_departure_time
      t.time    :b_arrival_time
      t.time    :c_departure_time
      t.time    :c_arrival_time

      t.timestamps
    end
  end
end
