require "rails_helper"

RSpec.describe 'As a newly registered user', type: :feature do
  include ActiveJob::TestHelper

  it 'receives an activation email when my account is created' do
    visit new_user_path

    fill_in 'user[email]',                 with: 'jane@example.com'
    fill_in 'user[first_name]',            with: 'Jane'
    fill_in 'user[last_name]',             with: 'Doe'
    fill_in 'user[password]',              with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_button 'Create Account'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Logged in as Jane Doe')
    expect(page).to have_content('This account has not yet been activated. Please check your email.')
    within('.inactive') { expect(page).to have_content('Inactive') }

    expect(enqueued_jobs.size).to eq(1)
    expect(enqueued_jobs.first[:args][0]).to eq('UserMailer')
    expect(enqueued_jobs.first[:args][1]).to eq('activate')
  end

  it 'can activate my account by clicking the email link' do
    user = create(:user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)

    visit '/dashboard'
    within('.inactive') { expect(page).to have_content('Inactive') }
    expect(user.active?).to eq(false)

    visit "/activate?activation_token=#{user.activation_token}"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Thank you! Your account is now activated.')
    within('.active') { expect(page).to have_content('Active') }
    expect(user.active?).to eq(true)
  end

  it 'cannot activate my account with invalid activation token' do
    user = create(:user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)

    visit '/activate?activation_token=34978y245ybg'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Your activation token is invalid, please contact support.')
    within('.inactive') { expect(page).to have_content('Inactive') }
    expect(user.active?).to eq(false)
  end

end
