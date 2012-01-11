module UserEntity
  
  def username=(val)
    val.nil? ? write_attribute(:username,val) : write_attribute(:username,val.downcase)
  end
  
  def email=(val)
    val.nil? ? write_attribute(:email,val) : write_attribute(:email,val.downcase)
  end
  
  def to_i
    id
  end
  
  def follow!(user)
    following_relationships.create(following_id: user.to_i)
    self.reload
  end
  
  def unfollow!(user)
    relationship = following_relationships.find_by_following_id(user.to_i)
    relationship.destroy
    self.reload
  end
  
  def following?(user)
    following_relationships.find_by_following_id(user.to_i)
  end
  
end