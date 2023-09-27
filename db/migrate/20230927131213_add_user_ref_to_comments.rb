class AddUserRefToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user, foreign_key: true, index: true
  end
end
