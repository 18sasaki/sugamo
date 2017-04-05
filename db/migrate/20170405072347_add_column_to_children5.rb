class AddColumnToChildren5 < ActiveRecord::Migration[5.0]
  def change
    add_column :children, :birthday, :date
  end
end
