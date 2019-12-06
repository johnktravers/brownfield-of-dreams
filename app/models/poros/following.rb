class Following
  attr_reader :username, :url

  def initialize(following_data)
    @username = following_data[:login]
    @url = following_data[:html_url]
  end
end
