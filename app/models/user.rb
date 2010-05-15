class User < ActiveRecord::Base
  has_many :messages, :order => "created_at DESC"
  has_many :replies
  
  has_many :followships
  has_many :followedusers, :through => :followships, :order => :name
  
  has_many :groupships
  has_many :groups, :through => :groupships
  
  has_many :questions, :order => "created_at DESC"
  has_many :answers
  has_many :comments
  
  has_many :favorite_questions, :order => "created_at DESC"
  
  acts_as_voter
  
  acts_as_authentic do |c|
      c.login_field = 'name'
  end
end
