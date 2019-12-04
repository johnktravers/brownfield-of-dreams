require 'rails_helper'

# When I visit '/admin/tutorials/new'
# And I fill in 'title' with a meaningful name
# And I fill in 'description' with a some content
# And I fill in 'thumbnail' with a valid YouTube thumbnail
# And I click on 'Save'
# Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
# And I should see a flash message that says "Successfully created tutorial."

describe "As an Admin." do
  let(:admin)    { create(:admin) }

  it "Can create a new tutorial with a video" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in "tutorial[title]", with: "Tying Shoes"
    fill_in "tutorial[description]", with: "How to tie your shoes."
    fill_in "tutorial[thumbnail]", with: "An untied shoe"
    fill_in "video[title]", with: "How to tie your shoes."
    fill_in "video[description]", with: "Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through."
    fill_in "video[video_id]", with: "J7ikFUlkP_k"

    click_on "Save"

    tutorial = Tutorial.last
    video = Video.last

    expect(current_path).to eq(tutorial_path(tutorial.id))
    expect(page).to have_content('Tutorial was successfully created')
    expect(page).to have_content(tutorial.title)
    expect(page).to have_link(video.title)
  end
end
