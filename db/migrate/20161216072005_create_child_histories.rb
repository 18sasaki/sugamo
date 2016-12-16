class CreateChildHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :child_histories do |t|
      t.date    :change_date,   :null => false
      t.integer :class_room_id, :null => false
      t.integer :child_id,      :null => false
      t.integer :total_m_count, :null => false
      t.integer :total_f_count, :null => false
      t.integer :total_count,   :null => false
      t.string  :change_code,   :null => false

      t.timestamps
    end
  end
end
