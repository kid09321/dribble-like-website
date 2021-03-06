class Comment < ActiveRecord::Base
  belongs_to :post, counter_cache: :comments_count
  belongs_to :user
  validates :content, presence: true
end
