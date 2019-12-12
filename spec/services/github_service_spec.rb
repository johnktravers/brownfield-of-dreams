require 'rails_helper'

RSpec.describe GithubService, type: :service do
  before :each do
    @service = GithubService.new(ENV['GITHUB_ACCESS_TOKEN'])
  end

  it 'initialize' do
    expect(@service).to be_a(GithubService)
  end

  it 'get_repos' do
    VCR.use_cassette('github_user_data') do
      repo_data = @service.get_repos

      expect(repo_data.first[:id]).to eq(162_659_364)
      expect(repo_data.first[:name]).to eq('johnktravers')
      expect(repo_data.first[:html_url])
        .to eq('https://github.com/check50/johnktravers')
    end
  end

  it 'get_followers' do
    VCR.use_cassette('github_user_data') do
      follower_data = @service.get_followers

      expect(follower_data.first[:id]).to eq(47_950_816)
      expect(follower_data.first[:login]).to eq('Jonpatt92')
      expect(follower_data.first[:html_url])
        .to eq('https://github.com/Jonpatt92')
    end
  end

  it 'get_followings' do
    VCR.use_cassette('github_user_data') do
      following_data = @service.get_followings

      expect(following_data.first[:id]).to eq(51_488_670)
      expect(following_data.first[:login]).to eq('mcat56')
      expect(following_data.first[:html_url])
        .to eq('https://github.com/mcat56')
    end
  end

  it 'get_invitee' do
    VCR.use_cassette('github_invitation_data_success') do
      invitee_data = @service.get_invitee('mcat56')

      expect(invitee_data[:email]).to eq('mcl86@cornell.edu')
      expect(invitee_data[:name]).to eq('Mary Lang')
    end
  end
end
