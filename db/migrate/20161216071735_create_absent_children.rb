class CreateAbsentChildren < ActiveRecord::Migration[5.0]
  def change
    create_table :absent_children do |t|
      t.integer :dairy_id,      :null => false
      t.integer :class_room_id, :null => false
      t.integer :child_id,      :null => false
      t.string  :absent_code,    :null => false
      t.string  :reason_code
      t.text    :reason_text

      t.timestamps
    end
  end
end
