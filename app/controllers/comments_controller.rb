class CommentsController < ApplicationController
  
  before_filter :login_required, :load_answer

  # POST /comments
  # POST /comments.xml
  def create
    @comment = @answer.comments.build(params[:comment])
    @comment.user_id = user_id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@question) }
        format.js
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = @answer.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(@question) }
      format.xml  { head :ok }
    end
  end
  
  def load_answer
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
  end
  
end
