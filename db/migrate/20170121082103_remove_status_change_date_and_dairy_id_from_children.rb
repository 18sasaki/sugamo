class RemoveStatusChangeDateAndDairyIdFromChildren < ActiveRecord::Migration[5.0]
  def change
    remove_column :children, :status_change_date, :date
    remove_column :children, :dairy_id, :integer
  end
end
