class CreateBusStops < ActiveRecord::Migration[5.0]
  def change
    create_table :bus_stops do |t|
      t.integer :bun_course_id, :null => false
      t.string  :name,          :null => false
      t.string  :name_k
      t.string  :view_name
      t.integer :number,        :null => false
      t.time    :a_arrival_time
      t.time    :b_arrival_time
      t.time    :c_arrival_time

      t.timestamps
    end
  end
end
