class AddColumnToChildren < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :history_code, :string, :null => false, :default => 'inc'
  end
end
