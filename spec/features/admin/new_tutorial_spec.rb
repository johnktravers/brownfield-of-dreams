require 'rails_helper'

describe 'As an Admin.' do
  let(:admin)    { create(:admin) }

  it 'Can create a new tutorial without a video' do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in 'tutorial[title]', with: 'Tying Shoes'
    fill_in 'tutorial[description]', with: 'How to tie your shoes.'
    fill_in 'tutorial[thumbnail]', with: 'An untied shoe'

    click_button 'Save'

    tutorial = Tutorial.last

    expect(current_path).to eq(tutorial_path(tutorial.id))
    expect(page).to have_content('Tutorial was successfully created')
    expect(page).to have_content(tutorial.title)
  end

  it 'Doesnt let me leave fields blank' do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in 'tutorial[title]', with: ''
    fill_in 'tutorial[description]', with: 'How to tie your shoes.'
    fill_in 'tutorial[thumbnail]', with: 'An untied shoe'

    click_button 'Save'

    expect(current_path).to eq(admin_tutorials_path)
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content('How to tie your shoes.')
    expect(page).to have_selector("input[value='An untied shoe']")
  end
end
