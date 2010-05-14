class SessionsController < ApplicationController
  
  def create
    self.current_user = User.authenticate(params[:name],params[:password])
    respond_to do |format|
      if logged_in?
        format.html { redirect_to(user_messages_url(current_user)) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def destroy
    self.current_user = nil
    redirect_to :controller => "users", :action => "index"
  end
  
end