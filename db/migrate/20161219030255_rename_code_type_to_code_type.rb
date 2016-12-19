class RenameCodeTypeToCodeType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :codes, :type, :code_type
  end
end
