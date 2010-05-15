class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :login_required, :only => [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to(user_messages_url(@user))
    else
      render :action => :new
    end
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      redirect_to(user_messages_url(@user))
    else
      render :action => :edit
    end
  end
end
