class User < ApplicationRecord
  # associations
  has_many :posts, foreign_key: 'author_id', inverse_of: 'author'
  has_many :likes
  has_many :comments

  def most_recent_posts(num = 3)
    posts.order(created_at: :desc).limit(num)
  end
end
