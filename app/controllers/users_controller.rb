class UsersController < ApplicationController
  
  before_filter :login_required, :except => [:new, :create]
  
  def index
    name = params[:name]
    @user = User.find_by_name(name)
    if @user
      redirect_to(user_messages_url(@user))
    else
      redirect_to :action => :new
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      self.current_user = @user
      redirect_to(user_messages_url(@user))
    else
      render :action => :new
    end
  end
  
end
