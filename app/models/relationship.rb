class Relationship < ActiveRecord::Base
  include RelationshipEntity
  belongs_to :follower, class_name: "User", counter_cache: :followings_count
  belongs_to :following, class_name: "User", counter_cache: :followers_count
  
end
