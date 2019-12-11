require 'rails_helper'

RSpec.describe 'User Friendships' do
  before :each do
    @john = create(:github_user)
    @jonathan = create(:user,
      github_id: '47950816',
      github_username: 'Jonpatt92',
      github_token: ENV['JON_GITHUB_TOKEN']
    )
  end

  it 'cannot add a github follower/following friend if they do not have an account' do
    VCR.use_cassette('github_user_data') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@john)

      visit dashboard_path

      save_and_open_page

      within('#follower-id-51488670') do
        expect(page).to_not have_link('Add as Friend')
      end

      within('#following-id-51488670') do
        expect(page).to_not have_link('Add as Friend')
      end
    end
  end

  it 'can add a github follower as a friend if they have an account' do
    VCR.use_cassette('github_user_data') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@john)

      visit dashboard_path

      within('#follower-id-47950816') do
        click_link('Add as Friend')
      end

      expect(current_path).to eq(dashboard_path)
      within('.friends') do
        expect(page).to have_content('Jonpatt92')
      end
    end
  end

end
