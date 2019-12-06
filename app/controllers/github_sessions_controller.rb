class GithubSessionsController < ApplicationController

  def create
    user_info = request.env['omniauth.auth']
    User.find_and_update(user_info, session[:user_id])
    redirect_to dashboard_path
  end

end
