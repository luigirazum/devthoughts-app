class Like < ApplicationRecord
  after_create :update_likes_counter
  after_destroy :update_likes_counter

  # validations
  validates :user, uniqueness: { scope: :post, message: "can't like a post more than once" }

  # associations
  belongs_to :user
  belongs_to :post, counter_cache: :likes_counter

  def update_likes_counter
    post.likes_counter = post.likes.count
  end
end
