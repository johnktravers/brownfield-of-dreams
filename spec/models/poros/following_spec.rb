require 'rails_helper'

RSpec.describe GithubUser, type: :model do
  it 'initialize' do
    raw_data = {
      id: '5436210',
      login: 'janedoe',
      html_url: 'https://github.com/janedoe'
    }
    following = GithubUser.new(raw_data)

    expect(following).to be_a(GithubUser)
    expect(following.github_id).to eq('5436210')
    expect(following.username).to eq('janedoe')
    expect(following.url).to eq('https://github.com/janedoe')
    expect(following.user_id).to eq(nil)

    expect(following.find_user_id).to eq(nil)
    expect(following.has_account?).to eq(false)
  end

  it 'find_user_id and has_account?' do
    raw_data = {
      id: '5436210',
      login: 'janedoe',
      html_url: 'https://github.com/janedoe'
    }
    user = create(:user, github_id: '5436210')
    following = GithubUser.new(raw_data)

    expect(following.find_user_id).to eq(user.id)
    expect(following.has_account?).to eq(true)
  end
end
