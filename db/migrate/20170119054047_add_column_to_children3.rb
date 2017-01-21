class AddColumnToChildren3 < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :dairy_id, :integer, :null => false
  end
end
