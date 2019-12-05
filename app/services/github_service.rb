class GithubService
  def initialize(token)
    @token = token
  end

  def get_user_repos
    response = fetch_data('/user/repos')
    parse_data(response)
  end


  private

  attr_reader :token

  def parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def fetch_data(url)
    conn.get(url)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:access_token] = token
    end
  end
end
