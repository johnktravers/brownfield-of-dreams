class GithubFacade
  def initialize(user)
    @user = user
  end

  def repos
    @raw_repos_data ||= service.get_repos

    repos = []
    @raw_repos_data.each do |repo_data|
      repos << Repo.new(repo_data) if repo_data[:owner][:id] == user.github_id.to_i
      break if repos.length == 5
    end
    repos
  end

  def followers
    @raw_followers_data ||= service.get_followers

    @raw_followers_data.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def followings
    @raw_followings_data ||= service.get_followings

    @raw_followings_data.map do |following_data|
      Following.new(following_data)
    end
  end

  def invitee(github_handle)
    @raw_invitee_data ||= service.get_invitee(github_handle)

    Invitee.new(@raw_invitee_data)
  end


  private
  attr_reader :user

  def service
    GithubService.new(user.github_token)
  end
end
