require 'modules/verifiable'

class Follower
  include Verifiable

  attr_reader :github_id, :username, :url, :user_id

  def initialize(follower_data)
    @github_id = follower_data[:id]
    @username = follower_data[:login]
    @url = follower_data[:html_url]
    @user_id = find_user_id # From verifiable module
  end
end
