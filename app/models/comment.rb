class Comment < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :post, counter_cache: :comments_counter
end
