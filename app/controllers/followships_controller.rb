class FollowshipsController < ApplicationController
  before_filter :login_required, :load_two
  
  def create
    Followship.follow(@userA, @userB)
    redirect_to(user_messages_url(@userA))
  end
  
  def destroy
    @followship = @userA.followships.find(params[:id])    
    @followship.destroy
    redirect_to(user_messages_url(@userA))
  end
  
  private
    def load_two
      @userA = User.find_by_id(user_id)
      @userB = User.find_by_id(params[:id])
    end
end
