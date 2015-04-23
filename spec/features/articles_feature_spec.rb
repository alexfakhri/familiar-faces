require 'rails_helper'

feature 'article' do

  context 'no articles have been added' do

    scenario 'displays a prompt to add an article' do
      visit '/articles'
      expect(page).to have_content 'No articles yet'
      expect(page).to have_content 'Add a new story'
    end

  end

  context 'articles have been added' do

    before do
      Article.create(title: 'One Awesome Story')
    end

    scenario 'Displaying an article' do
      visit '/articles'
      expect(page).to have_content 'One Awesome Story'
      expect(page).not_to have_content 'No articles yet'
    end

  end




end
