class CreateClassRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :class_rooms do |t|
      t.string :grade_code,   :null => false
      t.string :name,         :null => false
      t.string :short_name,   :null => false
      t.string :color,        :null => false
      t.string :teacher_name, :null => false
      t.string :sub_teacher_name

      t.timestamps
    end
  end
end
