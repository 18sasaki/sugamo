class AddColumnToClassRoomAttendances < ActiveRecord::Migration[5.0]
  def change
    add_column :class_room_attendances, :m_auth_count, :integer, :default => 0
    add_column :class_room_attendances, :f_auth_count, :integer, :default => 0
    add_column :class_room_attendances, :auth_count,   :integer, :default => 0
  end
end
