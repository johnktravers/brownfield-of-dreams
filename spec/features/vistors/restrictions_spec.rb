require 'rails_helper'

RSpec.describe 'As a visitor' do
  it 'sends me to the login page if I try to bookmark a video' do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    click_link 'Bookmark'

    expect(current_path).to eq(login_path)
    # expect(page).to have_content('Please login to bookmark a video')
  end

  it 'cannot see classroom content tutorials on home page' do
    tutorial = create(
      :tutorial,
      classroom: true,
      description: 'This is a dog.',
      thumbnail: 'https://i.ytimg.com/vi/MPV2METPeJU/maxresdefault.jpg'
    )
    create_list(:tutorial, 3)

    visit root_path

    expect(page).to_not have_link(tutorial.title)
    expect(page).to_not have_content(tutorial.description)
    expect(page).to_not have_css("img[src='#{tutorial.thumbnail}']")
  end

  it 'is redirected from classroom content tutorial show page' do
    tutorial = create(:tutorial, classroom: true)

    visit tutorial_path(tutorial)

    expect(current_path).to eq(root_path)
    expect(page)
      .to have_content('Please login to view classroom content tutorials.')
  end
end
