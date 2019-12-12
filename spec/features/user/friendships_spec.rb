require 'rails_helper'

RSpec.describe 'User Friendships' do
  before :each do
    @john = create(:github_user)
    @jonathan = create(:user,
                       github_id: '47950816',
                       github_username: 'Jonpatt92',
                       github_token: ENV['JON_GITHUB_TOKEN'])
  end

  it 'cannot add a follower/ing friend if they do not have an account' do
    VCR.use_cassette('github_user_data') do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@john)

      visit dashboard_path

      within('#follower-id-51488670') do
        expect(page).to_not have_button('Add as Friend')
      end

      within('#following-id-51488670') do
        expect(page).to_not have_button('Add as Friend')
      end
    end
  end

  it 'can add a github follower as a friend if they have an account' do
    VCR.use_cassette('twofold_github_user_data') do
      visit login_path

      fill_in 'session[email]', with: @john.email
      fill_in 'session[password]', with: @john.password

      click_button 'Log In'

      expect(current_path).to eq(dashboard_path)

      within('#follower-id-47950816') do
        click_button('Add as Friend')
      end

      expect(current_path).to eq(dashboard_path)

      @john.reload

      within('.friends') do
        expect(page).to have_selector("a[href='https://github.com/Jonpatt92']")
      end

      expect(page).to have_content("Yay, you added #{@jonathan.first_name} "\
        "#{@jonathan.last_name} as a friend!")

      within('#follower-id-47950816') do
        expect(page).to_not have_button('Add as Friend')
      end
    end
  end

  it 'can add a github following as a friend if they have an account' do
    VCR.use_cassette('twofold_github_user_data') do
      visit login_path

      fill_in 'session[email]', with: @john.email
      fill_in 'session[password]', with: @john.password

      click_button 'Log In'

      expect(current_path).to eq(dashboard_path)

      within('#following-id-47950816') do
        click_button('Add as Friend')
      end

      expect(current_path).to eq(dashboard_path)

      @john.reload

      within('.friends') do
        expect(page).to have_selector("a[href='https://github.com/Jonpatt92']")
      end

      expect(page).to have_content("Yay, you added #{@jonathan.first_name} "\
        "#{@jonathan.last_name} as a friend!")

      within('#following-id-47950816') do
        expect(page).to_not have_button('Add as Friend')
      end
    end
  end
end
