class ChangeChildIdToChildHistories < ActiveRecord::Migration[5.0]
  def up
    change_column_null :child_histories, :child_id, true
  end
 
  def down
    change_column_null :child_histories, :child_id, false
  end
end
