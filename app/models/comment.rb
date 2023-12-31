class Comment < ApplicationRecord
  after_create :update_comments_counter
  after_destroy :update_comments_counter

  # validations
  validates :text, presence: { message: "can't be blank" }

  # associations
  belongs_to :user
  belongs_to :post, counter_cache: :comments_counter

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
