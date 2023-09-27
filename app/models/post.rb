class Post < ApplicationRecord
  # associations
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', inverse_of: 'posts', counter_cache: :posts_counter
  has_many :comments
  has_many :likes
end
