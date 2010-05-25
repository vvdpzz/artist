class Message < ActiveRecord::Base
  
  belongs_to :user
  has_many :replies, :dependent => :destroy
  
  # make question model act as voteable
  # SOURCE: http://github.com/peteonrails/vote_fu
  # HOW TO USE: http://github.com/peteonrails/vote_fu/blob/master/README.markdown
  acts_as_voteable
  
end
