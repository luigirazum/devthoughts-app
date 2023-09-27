class AddUserRefToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :user, foreign_key: true, index: true
  end
end
