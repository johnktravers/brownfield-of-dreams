require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and is sent to the log in page' do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    click_link 'Bookmark'

    expect(page).to have_css("a[aria-label='You must sign in first']")
    expect(current_path).to eq(tutorial_path(tutorial))
  end
end
