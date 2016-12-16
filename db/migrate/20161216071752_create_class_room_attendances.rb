class CreateClassRoomAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :class_room_attendances do |t|
      t.integer :dairy_id,      :null => false
      t.integer :class_room_id, :null => false
      t.integer :m_count,       :null => false, :default => 0
      t.integer :f_count,       :null => false, :default => 0
      t.integer :count,         :null => false, :default => 0
      t.integer :m_pre_count,   :null => false, :default => 0
      t.integer :f_pre_count,   :null => false, :default => 0
      t.integer :pre_count,     :null => false, :default => 0
      t.integer :m_abs_count,   :null => false, :default => 0
      t.integer :f_abs_count,   :null => false, :default => 0
      t.integer :abs_count,     :null => false, :default => 0
      t.integer :m_sus_count,   :null => false, :default => 0
      t.integer :f_sus_count,   :null => false, :default => 0
      t.integer :sus_count,     :null => false, :default => 0

      t.timestamps
    end
  end
end
