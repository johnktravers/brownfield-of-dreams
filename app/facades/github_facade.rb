class GithubFacade
  def initialize(user)
    @user = user
  end

  def repos
    service = GithubService.new(@user.token)
    raw_repos_data = service.get_user_repos

    repos = []

    raw_repos_data.each do |repo_data|
      repos << Repo.new(repo_data) if repo_data[:owner][:id] == @user.uid.to_i
      break if repos.length == 5
    end

    repos
  end
end
