class RenameCodeKeyToCodeKey < ActiveRecord::Migration[5.0]
  def change
  	rename_column :codes, :key, :code_key
  end
end
