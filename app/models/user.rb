class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username
  include UserEntity
  has_secure_password
  validates_presence_of :password, on: :create
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_format_of :username, with: /^[-\w]+$/i, message: "limited to letters, numbers, or -"
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :posts, dependent: :destroy
  scope :recent, order('created_at desc')
  scope :active, order('last_seen_at desc')

end
