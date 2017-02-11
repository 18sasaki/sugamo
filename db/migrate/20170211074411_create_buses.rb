class CreateBuses < ActiveRecord::Migration[5.0]
  def change
    create_table :buses do |t|
      t.string :name,      :null => false
      t.string :view_name, :null => false

      t.timestamps
    end
  end
end
