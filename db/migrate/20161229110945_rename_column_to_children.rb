class RenameColumnToChildren < ActiveRecord::Migration[5.0]
  def change
  	rename_column :children, :history_code, :status_code
  	change_column_default :children, :status_code, 'enrollment'
  end
end
