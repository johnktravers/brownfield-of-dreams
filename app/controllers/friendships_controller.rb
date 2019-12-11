class FriendshipsController < ApplicationController

  def create
    friendship = current_user.friendships.new(friend_id: params[:friend_id])

    if friendship.save
      flash[:success] = 'Yay'
      redirect_to dashboard_path
    end
    binding.pry
  end

end
