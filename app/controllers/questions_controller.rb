# Created by Zheng-Yu Chen on 10-4-18.
# Copyright 2010 Cabooshine. All rights reserved.

class QuestionsController < ApplicationController

  before_filter :load_user, :except => [:index, :show]
  
  def favorite_question
    @question = Question.find(params[:question_id])
    fq = FavoriteQuestion.new
    fq.user_id = user_id
    fq.question_id = params[:question_id]
    respond_to do |format|
      if fq.save
        format.js
        format.html { redirect_to(@question) }
      end
    end
  end

  def favorite_question
    @question = Question.find(params[:question_id])

    @cu = User.find(user_id)
    
    if @cu.favorite_questions.find_by_question_id(@question.id) == nil
      fq = FavoriteQuestion.new
      fq.user_id = user_id
      fq.question_id = params[:question_id]
      respond_to do |format|
        if fq.save
          format.js
          format.html { redirect_to(@question) }
        end
      end
    end
    
  end


  def set_correct_answer
    @answer = Answer.find(params[:answer_id])
    @question = Question.find(params[:question_id])
    
    if @question.correct_answer == 0 && user_id == @question.user.id
      @question.update_attributes(:correct_answer => params[:answer_id])
    end
    
    respond_to do |format|
      format.js
      format.html {redirect_to(@question)}
    end
  end

  def vote_up
    @question = Question.find(params[:question_id])
    if params[:answer_id] != "0"
      @vote_type='answer'
      @answer = Answer.find(params[:answer_id])
      @user.vote_for(@answer)
    else
      @vote_type='question'
      @user.vote_for(@question)
    end
    respond_to do |format|
      format.js
      format.html {redirect_to(@question)}
    end
  end
  
  def vote_down
    @question = Question.find(params[:question_id])
    if params[:answer_id] != "0"
      @vote_type='answer'
      @answer = Answer.find(params[:answer_id])
      @user.vote_against(@answer)
    else
      @vote_type='question'
      @user.vote_against(@question)
    end
    respond_to do |format|
      format.html {redirect_to(@question)}
      format.js
    end
  end

  # GET /questions
  # GET /questions.xml
  def index

    if params[:search].nil?
      @questions = Question.all
    else
      @questions = Question.search params[:search]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end    

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])
    @question.update_attributes(:view => @question.view+1)
    @flag = false
    if user_id != nil
      @cu = User.find(user_id)
      if @cu.favorite_questions.find_by_question_id(@question.id)
        @flag = true
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = @user.questions.build

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = @user.questions.build(params[:question])

    respond_to do |format|
      if @question.save
        format.html { redirect_to(@question) }
        format.xml  { render :xml => @question,
                             :status => :created,
                             :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to(@question) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end

  private
  def load_user
    @user = User.find(user_id)
  end

end
