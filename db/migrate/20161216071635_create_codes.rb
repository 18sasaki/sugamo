class CreateCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :codes do |t|
      t.string :type,      :null => false
      t.string :key,       :null => false
      t.string :view_name, :null => false
      t.string :short_name
      t.string :check_string

      t.timestamps
    end
  end
end
