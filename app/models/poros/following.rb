require 'modules/verifiable'

class Following
  include Verifiable

  attr_reader :github_id, :username, :url, :user_id

  def initialize(following_data)
    @github_id = following_data[:id]
    @username = following_data[:login]
    @url = following_data[:html_url]
    @user_id = find_user_id # From verifiable module
  end
end
