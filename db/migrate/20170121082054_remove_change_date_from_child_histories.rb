class RemoveChangeDateFromChildHistories < ActiveRecord::Migration[5.0]
  def change
    remove_column :child_histories, :change_date, :date
  end
end
