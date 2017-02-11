class CreateDairyChildBusStops < ActiveRecord::Migration[5.0]
  def change
    create_table :dairy_child_bus_stops do |t|
      t.integer :dairy_id,    :null => false
      t.integer :child_id,    :null => false
      t.integer :bus_stop_id, :null => false
      t.text    :reason_text
      t.string  :dcb_code,    :null => false
      t.integer :unuse_flg
      t.integer :pick_up_no,  :null => false
      t.string  :fare_code,   :default => 'unnecessary'

      t.timestamps
    end
  end
end
