class GithubService
  def get_user_repos
    response = fetch_data('/user/repos')
    parse_data(response)
  end


  private

  def parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def fetch_data(url)
    conn.get(url)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:access_token] = ENV['GITHUB_ACCESS_TOKEN']
    end
  end
end
