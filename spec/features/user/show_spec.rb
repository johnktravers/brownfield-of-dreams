require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before :each do
    @user = create(:github_user)
  end

  it "Has a link to authorize Github account" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_link("Connect to GitHub")
    expect(page).to_not have_css(".github")
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
        'Jonpatt92' => "https://github.com/Jonpatt92",
        'mcat56'    => "https://github.com/mcat56"
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
end
