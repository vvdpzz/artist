class MessagesController < ApplicationController
  
  before_filter :login_required, :load_user
  before_filter :permit_modify, :only => [:new, :edit, :destroy]

  def vote_up
    @message = Message.find(params[:message_id])
    @user.vote_for(@message)
    respond_to do |format|
      format.js
      format.html {redirect_to(@question)}
    end
  end
  
  def vote_down
    @message = Message.find(params[:message_id])
    @user.vote_against(@message)
    respond_to do |format|
      format.html {redirect_to(@question)}
      format.js
    end
  end
  
  # GET /messages
  # GET /messages.xml
  def index

    @current_user = User.find(user_id)
    @users = User.all

    @peoples=[]
    @users.each do |user|
      if not Followship.exists?(@current_user, user)
        @peoples<<user
      end
    end
    @peoples.delete(@current_user)

    followedUserIDS=[]
    @current_user.followedusers.each do |followedUser|
      followedUserIDS << followedUser.id
    end
    followedUserIDS << @current_user.id
    
    @messages = Message.find( :all,
                              :order => "created_at DESC",
                              :limit => 20,
                              :conditions => { :user_id => followedUserIDS } )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = @user.messages.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = @user.messages.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = @user.messages.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = @user.messages.build(params[:message])

    respond_to do |format|
      if @message.save
        format.html { redirect_to(user_messages_url(@user)) }
        format.js
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = @user.messages.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to(user_messages_url(@user)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = @user.messages.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(user_messages_url(@user)) }
      format.xml  { head :ok }
    end
  end
  
  def load_user
    @user = User.find(params[:user_id])
  end
  
  def permit_modify
    if user_id != @user.id
      redirect_to user_messages_path
    end
  end
  
end
