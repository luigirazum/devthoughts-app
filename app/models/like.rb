class Like < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :post, counter_cache: :likes_counter
end
