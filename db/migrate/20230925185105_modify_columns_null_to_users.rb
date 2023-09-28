class ModifyColumnsNullToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :posts_counter, false
  end
end
