class GithubFacade
  def initialize(user)
    @user = user
  end

  def repos
    @raw_repos_data ||= service.get_user_repos

    repos = []
    @raw_repos_data.each do |repo_data|
      repos << Repo.new(repo_data) if repo_data[:owner][:id] == user.github_id.to_i
      break if repos.length == 5
    end
    repos
  end

  def followers
    @raw_followers_data ||= service.get_user_followers

    @raw_followers_data.map do |follower_data|
      Follower.new(follower_data)
    end
  end


  private

  attr_reader :user

  def service
    GithubService.new(user.github_token)
  end

end
