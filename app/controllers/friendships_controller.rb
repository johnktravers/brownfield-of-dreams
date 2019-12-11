class FriendshipsController < ApplicationController

  def create
    friendship = current_user.friendships.new(friend_id: params[:friend_id])
    new_friend = User.find_by(id: friendship.friend_id)

    if new_friend && friendship.save
      flash[:success] = "Yay, you added #{new_friend.first_name} #{new_friend.last_name} as a friend!"
      redirect_to dashboard_path
    else
      render file: 'public/404', status: :not_found
    end
  end

end
