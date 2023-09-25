class ModifyColumnsNullToPosts < ActiveRecord::Migration[7.0]
  def change
    change_column_null :posts, :title, false
    change_column_null :posts, :text, false
    change_column_null :posts, :comments_counter, false
    change_column_null :posts, :likes_counter, false
  end
end
