require 'rails_helper'

feature 'article' do

  context 'no articles have been added' do

    scenario 'displays a prompt to add an article' do
      visit '/articles'
      expect(page).to have_content 'No articles yet'
      expect(page).to have_content 'Add a new story'
    end

  end

end
