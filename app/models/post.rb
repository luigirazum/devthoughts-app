class Post < ApplicationRecord
  after_create :update_posts_counter
  after_destroy :update_posts_counter

  # associations
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', inverse_of: 'posts', counter_cache: :posts_counter
  has_many :comments
  has_many :likes

  def most_recent_comments(number = 5)
    comments.order(created_at: :desc).limit(number)
  end

  def update_posts_counter
    author.posts_counter = author.posts.count
  end
end
