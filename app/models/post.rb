class Post < ActiveRecord::Base
  include PostEntity
  belongs_to :user, counter_cache: :posts_count
  belongs_to :parent, class_name: 'Post'
  has_many :replies, class_name: 'Post', foreign_key: 'post_id'
  scope :recent, order('created_at desc')
  scope :before, lambda { |d| where("created_at < d") }
  scope :timeline, lambda { |user| where("user_id IN (SELECT following_id FROM relationships WHERE follower_id = :user_id) OR user_id = :user_id", { user_id: user.to_i }) }
end
