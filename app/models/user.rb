class User < ActiveRecord::Base
  
  before_save :hash_password
  
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
  
  validates_uniqueness_of :email, :on => :create, :message => "must be unique"
  validates_format_of :email, :with => /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)\z/i, :on => :create, :message => "is invalid"
  
  attr_accessor :password, :password_confirmation
  
  validates_length_of :password, :within => 6..20, :on => :create, :message => "must be present and length between 6 to 20"
  
  validates_confirmation_of :password, :on => :create, :message => "should match confirmation"
  
  validates_length_of :name, :within => 1..20, :on => :create, :message => "must be present"
  
  def self.authenticate(name, password)
    user = User.find_by_name(name)
    if user
      input_password_hashed = Digest::SHA1.hexdigest(password + user.salt + "ohyes")
      if user.hashed_password != input_password_hashed
        user = nil
      end
    end
    user
  end

# Bug here
# if save failed we must destroy this record
  private
    def hash_password
      self.salt = self.object_id.to_s + rand.to_s
      self.hashed_password = Digest::SHA1.hexdigest(password + salt + "ohyes")
    end
end
