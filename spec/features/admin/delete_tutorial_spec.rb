require 'rails_helper'

describe 'An Admin can delete a tutorial' do
  let(:tutorial) { create(:tutorial) }
  let(:admin)    { create(:admin) }

  scenario 'Which deletes that tutorials videos' do
    VCR.use_cassette('new_youtube_video') do
      create_list(:video, 3, tutorial: tutorial)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      click_button 'Destroy'

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to_not have_content(tutorial.title)
      expect(page).to_not have_link('Edit')
      expect(page).to_not have_button('Destroy')
      expect(Video.all).to eq([])
    end
  end
end
