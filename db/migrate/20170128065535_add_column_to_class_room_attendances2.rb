class AddColumnToClassRoomAttendances2 < ActiveRecord::Migration[5.0]
  def change
    add_column :class_room_attendances, :m_stop_count, :integer, :default => 0
    add_column :class_room_attendances, :f_stop_count, :integer, :default => 0
    add_column :class_room_attendances, :stop_count,   :integer, :default => 0
  end
end
