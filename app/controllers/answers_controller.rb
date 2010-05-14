class AnswersController < ApplicationController

  before_filter :load_user, :only => :create
  before_filter :load_question

  def create
    @answer = @question.answers.build(params[:answer])
    @answer.user_id = @user.id
    respond_to do |format|
      if @answer.save
        format.html { redirect_to(@question) }
        format.js
        format.xml  { render :xml => @answer, :status => :created, :location => @answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def load_user
    @user = User.find(user_id)
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

end