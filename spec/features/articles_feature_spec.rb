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

  context 'creating articles' do

    scenario 'prompts a user to fill out a form, then displayes article' do
        visit '/articles'
        click_link 'Add a new story'
        fill_in 'Title', with: 'One Awesome Story'
        fill_in 'Story', with: 'Something amazing added here'
        click_button 'Add Story'
        expect(page).to have_content 'One Awesome Story'
        expect(current_path).to eq '/articles'
    end

  end




end
