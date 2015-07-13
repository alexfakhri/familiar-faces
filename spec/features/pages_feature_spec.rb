require 'rails_helper'

feature 'static pages' do

  context 'user should be able to visit static pages' do

    scenario 'shows about page' do
      visit '/about'
      expect(current_path).to eq '/about'
      expect(page).to have_content 'About'
    end

    scenario 'shows contact page' do
      visit '/contact'
      expect(current_path).to eq '/contact'
      expect(page).to have_content 'Contact'
    end

    scenario 'shows email thank you page' do
      visit '/thank-you'
      expect(current_path).to eq '/thank-you'
      expect(page).to have_content 'Thank You'
    end

  end

end
