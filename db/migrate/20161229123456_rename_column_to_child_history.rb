class RenameColumnToChildHistory < ActiveRecord::Migration[5.0]
  def change
  	rename_column :child_histories, :change_code, :history_code
  end
end
