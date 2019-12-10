class Following
  attr_reader :username, :url, :github_id

  def initialize(following_data)
    @github_id = following_data[:id]
    @username = following_data[:login]
    @url = following_data[:html_url]
  end
end
