class AddAuthorRefToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :author, references: :users, null: false, foreign_key: { to_table: :users }, index: true
  end
end
