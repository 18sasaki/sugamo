class AddColumnToChildren2 < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :status_change_date, :date
  end
end
