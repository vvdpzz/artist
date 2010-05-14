class Group < ActiveRecord::Base
  has_many :groupships
  has_many :users, :through => :groupships
end
