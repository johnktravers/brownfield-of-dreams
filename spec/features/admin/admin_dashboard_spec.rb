require 'rails_helper'

feature 'An admin visiting the admin dashboard' do
  it 'can see all tutorials' do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    expect(page).to have_css('.admin-tutorial-card', count: 2)
  end

  it 'cannot be accessed by a user' do
    user = create(:user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)

    visit admin_dashboard_path

    expect(page)
      .to have_content('The page you were looking for doesn\'t exist (404)')
  end
end
