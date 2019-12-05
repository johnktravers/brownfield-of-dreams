class GithubFacade

  def repos
    service = GithubService.new
    raw_repos_data = service.get_user_repos

    repos = []

    raw_repos_data.each do |repo_data|
      repos << Repo.new(repo_data) if repo_data[:owner][:id] == 46035439 # Change to specific username
      break if repos.length == 5
    end

    repos
  end


end
