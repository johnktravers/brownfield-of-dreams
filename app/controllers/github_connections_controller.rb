class GithubConnectionsController < ApplicationController

  def create
    user_info = request.env['omniauth.auth']
    user = current_user
    user.update_github(user_info)
    
    redirect_to dashboard_path
  end

end
