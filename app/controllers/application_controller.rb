class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_admin?
  helper_method :list_tags
  helper_method :github_connection

  add_flash_types :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user.role == 'admin' if current_user
  end

  def github_connection
    current_user.github_id if current_user
  end

  def four_oh_four
    raise ActionController::RoutingError.new('Not Found')
  end
end
