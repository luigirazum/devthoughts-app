class User < ApplicationRecord
  # validations
  validates :name, presence: { message: "can't be blank" }
  validates :name, length: { in: 5..50, message: "must be 5 to 50 characters"}

  # associations
  has_many :posts, foreign_key: 'author_id', inverse_of: 'author'
  has_many :likes
  has_many :comments

  def most_recent_posts(num = 3)
    posts.order(created_at: :desc).limit(num)
  end
end
