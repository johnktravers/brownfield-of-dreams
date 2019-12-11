require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_button 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content('Bookmark added to your dashboard')
  end

  it "can't add the same bookmark more than once" do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_button 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')
    click_button 'Bookmark'
    expect(page).to have_content('Already in your bookmarks')
  end

  it "Tells me when there isn't a tutorial with that id" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(3424233)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Tutorial with given ID does not exist.')
  end
end
