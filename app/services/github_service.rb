class GithubService
  def initialize(token)
    @token = token
  end

  def get_repos
    response = fetch_data('/user/repos')
    parse_data(response)
  end

  def get_followers
    response = fetch_data('/user/followers')
    parse_data(response)
  end

  def get_followings
    response = fetch_data('/user/following')
    parse_data(response)
  end

  def get_invitee(github_handle)
    response = fetch_data("/users/#{github_handle}")
    parse_data(response)
  end

  private

  attr_reader :token

  def parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def fetch_data(url)
    connection.get(url)
  end

  def connection
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:access_token] = token
    end
  end
end
