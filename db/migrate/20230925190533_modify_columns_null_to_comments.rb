class ModifyColumnsNullToComments < ActiveRecord::Migration[7.0]
  def change
    change_column_null :comments, :text, false
  end
end
