class RemoveAuthorForeignKeyOnPosts < ActiveRecord::Migration[7.0]
  def change
    remove_index :posts, column: :author_id, if_exists: true
    remove_foreign_key :posts, column: :author_id, if_exists: true
    remove_column :posts, :author_id, if_exists: true
  end
end
