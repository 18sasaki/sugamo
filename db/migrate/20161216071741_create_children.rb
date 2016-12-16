class CreateChildren < ActiveRecord::Migration[5.0]
  def change
    create_table :children do |t|
      t.integer :unique_num,  :null => false
      t.integer :class_room_id
      t.string  :post_number, :null => false
      t.string  :address,     :null => false
      t.string  :l_phone_number
      t.string  :c_phone_number
      t.string  :full_name,   :null => false
      t.string  :full_name_f, :null => false
      t.string  :sex_code,    :null => false

      t.timestamps
    end
  end
end
