class CreateDairies < ActiveRecord::Migration[5.0]
  def change
    create_table :dairies do |t|
      t.date    :date,         :null => false
      t.string  :dow,          :null => false
      t.integer :att_syou_flg, :null => false, :default => 1
      t.integer :att_chuu_flg, :null => false, :default => 1
      t.integer :att_chou_flg, :null => false, :default => 1
      t.string  :dairy_code,   :null => false, :default => "undec"

      t.timestamps
    end
  end
end
