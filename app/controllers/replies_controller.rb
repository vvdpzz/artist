class RepliesController < ApplicationController
  
  before_filter :login_required, :load_message

  # POST /replies
  # POST /replies.xml
  def create
    @reply = @message.replies.build(params[:reply])
    @reply.user_id = user_id
    respond_to do |format|
      if @reply.save
        format.js
        format.html { redirect_to(user_messages_path) }
        format.xml  { render :xml => @reply, :status => :created, :location => @reply }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /replies/1
  # DELETE /replies/1.xml
  def destroy
    @reply = @message.replies.find(params[:id])
    @reply.destroy

    respond_to do |format|
      format.html { redirect_to([@user,@message]) }
      format.xml  { head :ok }
    end
  end
  
  def load_message
      @message = Message.find(params[:message_id])
  end
  
end
