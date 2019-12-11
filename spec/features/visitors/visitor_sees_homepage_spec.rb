require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      create_list(:video, 2, tutorial_id: tutorial1.id)
      create_list(:video, 2, tutorial_id: tutorial2.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end
    end

    it "Can get started" do
      visit root_path
      click_link "Get Started"

      expect(current_path).to eq(get_started_path)

      within ".started-main" do
        click_link "Register"
      end

      expect(current_path).to eq(register_path)

      visit get_started_path
      within ".started-main" do
        click_link "Sign In"
      end

      expect(current_path).to eq(login_path)

      visit get_started_path

      click_link "about"
      expect(current_path).to eq(about_path)
    end
  end
end
