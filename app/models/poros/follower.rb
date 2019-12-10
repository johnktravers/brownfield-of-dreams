class Follower
  attr_reader :username, :url, :github_id

  def initialize(follower_data)
    @github_id = follower_data[:id]
    @username = follower_data[:login]
    @url = follower_data[:html_url]
  end
end
