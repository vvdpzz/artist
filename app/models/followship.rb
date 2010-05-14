class Followship < ActiveRecord::Base
  belongs_to :user
  belongs_to :followeduser, :class_name => "User", :foreign_key => "followeduser_id"
  validates_presence_of :user_id, :followeduser_id
  
  def self.exists?(userA, userB)
    not find_by_user_id_and_followeduser_id(userA, userB).nil?
  end
  
  def self.follow(userA, userB)
    unless Followship.exists?(userA, userB)
      create(:user => userA, :followeduser => userB)
    end
  end
  
  def self.unfollow(userA, userB)
    destroy(find_by_user_id_and_followeduser_id(userA, userB))    
  end
  
end
