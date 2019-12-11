class FriendshipController < ApplicationController
  def create
    if current_user.add_friend(params[:friend_id])
      friend = User.find(params[:friend_id])
      friend.add_friend(current_user.id)
      flash[:success] = "You have added #{friend.github_username} as a friend"
    else
      flash[:notice] = "Unable to add them as a friend"
    end
    redirect_to dashboard_path
  end
end
