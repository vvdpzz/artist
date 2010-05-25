class Reply < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :message
  
  # make question model act as voteable
  # SOURCE: http://github.com/peteonrails/vote_fu
  # HOW TO USE: http://github.com/peteonrails/vote_fu/blob/master/README.markdown
  acts_as_voteable
  
end
