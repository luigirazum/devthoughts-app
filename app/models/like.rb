class Like < ApplicationRecord
  after_create :update_likes_counter
  after_destroy :update_likes_counter

  # associations
  belongs_to :user
  belongs_to :post, counter_cache: :likes_counter

  def update_likes_counter
    post.likes_counter = post.likes.count
  end
end
