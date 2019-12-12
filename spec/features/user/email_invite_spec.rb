require 'rails_helper'

RSpec.describe 'As a registered user', type: :feature do
  before(:each) do
    user = create(:github_user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end
  include ActiveJob::TestHelper

  it 'Can send an email invite to another github user' do
    VCR.use_cassette('github_invitation_data_success') do
      visit dashboard_path
      click_link 'Send an Invite'

      expect(current_path).to eq(invite_path)

      fill_in 'invite[github_handle]', with: 'mcat56'
      click_button 'Send Invite'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Successfully sent invite!')
      expect(enqueued_jobs.size).to eq(1)
      expect(enqueued_jobs.first[:args][0]).to eq('UserMailer')
      expect(enqueued_jobs.first[:args][1]).to eq('invite')
    end
  end

  it "Tells me when the invited user doesn't have an email" do
    VCR.use_cassette('github_invitation_data_failure') do
      visit dashboard_path

      click_link 'Send an Invite'

      expect(current_path).to eq(invite_path)

      fill_in 'invite[github_handle]', with: 'rhksdg324'
      click_button 'Send Invite'

      expect(enqueued_jobs.size).to eq(0)
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github user you selected doesn't "\
        'have an email address associated with their account.')
    end
  end

  it "Doesn't let me send an invite if I haven't authenticated" do
    unverified_user = create(:user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(unverified_user)

    visit dashboard_path

    expect(page).to_not have_link('Send an Invite')
  end
end
