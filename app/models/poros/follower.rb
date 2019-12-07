class Follower
  attr_reader :username, :url

  def initialize(follower_data)
    @username = follower_data[:login]
    @url = follower_data[:html_url]
  end
end
