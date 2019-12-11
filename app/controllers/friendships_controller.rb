class FriendshipsController < ApplicationController

  def create
    friendship = current_user.friendships.new(friend_id: params[:friend_id])
    new_friend = User.find(friendship.friend_id)
    if new_friend && friendship.save
      flash[:success] = "Yay, you added #{new_friend.first_name} #{new_friend.last_name} as a friend!"
    else
      flash[:notice] = "That user doesn't exist"
    end
    redirect_to dashboard_path
  end

end
