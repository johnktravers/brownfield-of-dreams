require 'rails_helper'

describe 'When I visit a Tutorials show page', type: :feature do
  it 'I see the tutorials videos if it has any' do
    tutorial = create(:tutorial)
    create_list(:video, 2, tutorial: tutorial)
    video1 = create(:video, tutorial: tutorial)
    video2 = create(:video, tutorial: tutorial)

    visit tutorial_path(tutorial)

    expect(page).to have_content(tutorial.title)
    expect(page).to have_link(video1.title)
    expect(page).to have_link(video2.title)
  end

  it 'Tells me when there are no videos' do
    tutorial = create(:tutorial)

    visit tutorial_path(tutorial)

    expect(page).to have_content(tutorial.title)
    expect(page).to have_content('This tutorial has no videos')
  end
end
