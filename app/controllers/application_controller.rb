class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_admin?
  helper_method :find_bookmark
  helper_method :list_tags
  helper_method :tutorial_name
  helper_method :github_connection
  helper_method :verify_user
  helper_method :already_friend?

  add_flash_types :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def verify_user(github_id)
    User.find_by(github_id: github_id)
  end

  def already_friend?(github_id)
    current_user.all_friends.any?{|friend| friend.github_id == github_id}
  end

  def current_admin?
    current_user.role == 'admin' if current_user
  end

  def github_connection
    current_user.github_id if current_user
  end

  def find_bookmark(id)
    current_user.user_videos.find_by(video_id: id)
  end

  def tutorial_name(id)
    Tutorial.find(id).title
  end

  def four_oh_four
    raise ActionController::RoutingError.new('Not Found')
  end
end
