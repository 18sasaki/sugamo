class AddColumnToChildrenHistories < ActiveRecord::Migration[5.0]
  def change
    add_column :child_histories, :dairy_id, :integer, :null => false
  end
end
