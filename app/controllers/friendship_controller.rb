class FriendshipController < ApplicationController
  def create
    current_user.add_friend(params[:friend_id]))
    redirect_to dashboard_path
  end
end
