require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before :each do
    @users = [create(:user), create(:admin)]
  end

  it 'can see account details' do
    VCR.use_cassette('github_user_repos') do
      @users.each do |user|
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        expect(page).to have_content("#{user.first_name} #{user.last_name}")
        expect(page).to have_content(user.email)
      end
    end
  end

  it 'can see links to five of my github repos' do
    VCR.use_cassette('github_user_repos') do
      @users.each do |user|
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

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
              "a[href='https://github.com/johnktravers/#{repo_name}']",
              text: repo_name
            )
          end
        end
      end
    end
  end
end
