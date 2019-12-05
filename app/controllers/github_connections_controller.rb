class GithubConnectionsController < ApplicationController

  def create
    user_info = request.env['omniauth.auth']

    user = current_user
    user.update(
      github_username: user_info['extra']['raw_info']['login'],
      github_id: user_info['uid'],
      github_token: user_info['credentials']['token']
    )

    redirect_to dashboard_path
  end

end
