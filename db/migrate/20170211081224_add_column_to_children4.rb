class AddColumnToChildren4 < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :main_bus_stop_id, :integer
    add_column :children, :sub_bus_stop_id, :integer
    add_column :children, :irregular_judge_str, :string
  end
end
