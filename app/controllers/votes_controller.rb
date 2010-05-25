class VotesController < ApplicationController
  before_filter :login_required, :load_user
  
  def vote_up
    if params[:type] == "q"
      @vote_type='question'
      @user.vote_for(Question.find(params[:id]))
    elsif params[:type] == "a"
      @vote_type='answer'
      @user.vote_for(Answer.find(params[:id]))
    elsif params[:type] == "m"
      @vote_type='message'
      @user.vote_for(Message.find(params[:id]))
    elsif params[:type] == "r"
      @vote_type='reply'
      @user.vote_for(Reply.find(params[:id]))
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def vote_down
    if params[:type] == "q"
      @vote_type='question'
      @user.vote_against(Question.find(params[:id]))
    elsif params[:type] == "a"
      @vote_type='answer'
      @user.vote_against(Answer.find(params[:id]))
    elsif params[:type] == "m"
      @vote_type='message'
      @user.vote_against(Message.find(params[:id]))
    elsif params[:type] == "r"
      @vote_type='reply'
      @user.vote_for(Reply.find(params[:id]))
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  private
  def load_user
    @user = User.find(user_id)
  end
end
