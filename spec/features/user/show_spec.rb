require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before :each do
    @user = create(:github_user)
  end

  it 'Has a link to authorize Github account if default user' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_link('Connect to GitHub')
    expect(page).to_not have_css('.github')
  end

  it "Doesn't have a link to authorize Github account if admin user" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit dashboard_path

    expect(page).to_not have_link('Connect to GitHub')
    expect(page).to_not have_css('.github')
  end

  it 'can see account details' do
    VCR.use_cassette('github_user_data') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

      expect(page).to have_content("#{@user.first_name} #{@user.last_name}")
      expect(page).to have_content(@user.email)
    end
  end

  it 'can see links to five of my github repos' do
    VCR.use_cassette('github_user_data') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

      repo_names = [
        'activerecord-obstacle-course',
        'advent_of_code',
        'apartments_1908',
        'apollo_14',
        'B2_mid_mod_1908'
      ]

      within '.github' do
        repo_names.each do |repo_name|
          expect(page).to have_selector(
            "a[href='https://github.com/#{@user.github_username}/#{repo_name}']",
            text: repo_name
          )
        end
      end
    end
  end

  it 'can see links to my followers' do
    VCR.use_cassette('github_user_data') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

      followers = {
        'Jonpatt92' => 'https://github.com/Jonpatt92',
        'mcat56'    => 'https://github.com/mcat56'
      }

      within '.github' do
        followers.each do |follower, url|
          expect(page).to have_selector(
            "a[href='#{url}']",
            text: follower
          )
        end
      end
    end
  end

  it 'can see links to my followings' do
    VCR.use_cassette('github_user_data') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

      following = {
        'url'      => 'https://github.com/mcat56',
        'username' => 'mcat56'
      }

      within '.github' do
          expect(page).to have_selector(
            "a[href='#{following['url']}']",
            text: following['username']
          )
      end
    end
  end

  it 'does not see a friends section if I have no friends' do
    VCR.use_cassette('github_user_data') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

      expect(page).to_not have_css('.friends')
    end
  end

  it 'Can see my bookmarked videos, sorted by tutorial and video position' do
    VCR.use_cassette('github_user_data') do
      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)

      create_list(:video, 3, tutorial: tutorial_1)
      create_list(:video, 4, tutorial: tutorial_2)

      Video.all.each do |video|
        create(:user_video, user: @user, video: video )
      end

      create_list(:user_video, 3)
      create_list(:video, 2, tutorial: tutorial_1)
      create_list(:video, 2, tutorial: tutorial_2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

      within "#tutorial-#{tutorial_1.id}" do
        expect(page).to have_css('.bookmarked-video', count: 3)
        expect(page).to have_link(Video.first.title)
      end

      within "#tutorial-#{tutorial_2.id}" do
        expect(page).to have_css('.bookmarked-video', count: 4)
      end
    end
  end

  it 'I see that I have no bookmarked videos' do
    VCR.use_cassette('github_user_data') do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content('You have no bookmarked videos')
      expect(page).to_not have_css('.bookmarked-video')
    end
  end
end
