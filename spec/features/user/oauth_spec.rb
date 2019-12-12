require 'rails_helper'

RSpec.describe 'I can authenticate using Oauth' do
  before(:each) do
    OmniAuth.config.test_mode          = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      'provider' => 'github',
      'uid' => '46035439',
      'credentials' => {
        'token' => ENV['GITHUB_ACCESS_TOKEN'],
        'expires' => false
      },
      'extra' => {
        'raw_info' => {
          'login' => 'johnktravers',
          'id' => 46_035_439
        }
      }
    )
    Rails
      .application
      .env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  it 'Can connect to a github account' do
    VCR.use_cassette('github_user_data') do
      user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)

      visit dashboard_path
      click_link 'Connect to GitHub'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_css('.github')
      expect(page).to have_selector(
        "a[href='https://github.com/#{user.github_username}/advent_of_code']",
        text: 'advent_of_code'
      )
    end
  end
end
