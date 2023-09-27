class User < ApplicationRecord
  # associations
  has_many :posts, foreign_key: 'author_id', inverse_of: 'author'
  has_many :likes
  has_many :comments
end
