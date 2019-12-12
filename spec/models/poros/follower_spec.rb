require 'rails_helper'

RSpec.describe Follower, type: :model do
  it 'initialize' do
    raw_data = {
      id: '5436210',
      login: 'janedoe',
      html_url: 'https://github.com/janedoe'
    }
    follower = Follower.new(raw_data)

    expect(follower).to be_a(Follower)
    expect(follower.github_id).to eq('5436210')
    expect(follower.username).to eq('janedoe')
    expect(follower.url).to eq('https://github.com/janedoe')
    expect(follower.user_id).to eq(nil)

    expect(follower.find_user_id).to eq(nil)
    expect(follower.has_account?).to eq(false)
  end

  it 'find_user_id and has_account?' do
    raw_data = {
      id: '5436210',
      login: 'janedoe',
      html_url: 'https://github.com/janedoe'
    }
    user = create(:user, github_id: '5436210')
    follower = Follower.new(raw_data)

    expect(follower.find_user_id).to eq(user.id)
    expect(follower.has_account?).to eq(true)
  end
end
