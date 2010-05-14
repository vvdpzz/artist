# Created by Zheng-Yu Chen on 10-4-18.
# Copyright 2010 Cabooshine. All rights reserved.

class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, :dependent => :destroy
  
  has_many :favorite_questions, :order => "created_at DESC"
  
  validates_presence_of :title, :on => :create, :message => "标题不能为空"
  validates_presence_of :detail, :on => :create, :message => "问题描述不能为空"
  
  # make question model act as taggable
  # SOURCE: http://github.com/jviney/acts_as_taggable_on_steroids
  # HOW TO USE: http://github.com/jviney/acts_as_taggable_on_steroids/blob/master/README
  acts_as_taggable
  
  # make question model act as voteable
  # SOURCE: http://github.com/peteonrails/vote_fu
  # HOW TO USE: http://github.com/peteonrails/vote_fu/blob/master/README.markdown
  acts_as_voteable
  
  # thinking_sphinx definition
  # below code is to set up an index on question model to index question's title & detail
  # to index data by: rake thinking_sphinx:index
  # fire Sphinx up by: rake thinking_sphinx:start
  # SOURCE: http://freelancing-god.github.com/ts/en/
  # HOW TO USE: http://freelancing-god.github.com/ts/en/quickstart.html
  define_index do
    indexes detail
    indexes title
  end
  
  # set the url format like id-title
  # e.g. http://0.0.0.0:3000/questions/1_foo_bar
  # DO NOT FORGET to modify Question.find method in controller

  #def to_param
    #"#{id}-#{title}"
  #end
  
end
