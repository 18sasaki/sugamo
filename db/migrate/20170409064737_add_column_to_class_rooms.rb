class AddColumnToClassRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :class_rooms, :yeard, :integer, :null => false
  end
end
