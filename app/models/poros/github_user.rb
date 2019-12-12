require 'modules/verifiable'

class GithubUser
  include Verifiable

  attr_reader :github_id, :username, :url, :user_id

  def initialize(github_data)
    @github_id = github_data[:id]
    @username = github_data[:login]
    @url = github_data[:html_url]
    @user_id = find_user_id # From verifiable module
  end
end
