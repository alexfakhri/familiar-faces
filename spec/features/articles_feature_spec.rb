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

    before(:each) do
      visit '/articles'
      click_link 'Add a new story'
      fill_in 'Title', with: 'One Awesome Story'
      fill_in 'Story', with: 'Something amazing added here'
      attach_file "article[photo]", "#{Rails.root}/public/images/test/test.jpg"
      click_button 'Add Story'
      click_link 'One Awesome Story'
    end

    scenario 'displays article title on show page' do
      expect(page).to have_content 'One Awesome Story'
    end

    scenario 'displays article story on show page' do
      expect(page).to have_content 'Something amazing added here'
    end

    scenario 'displays article image on show page' do
      expect(page).to have_css("img[alt=Test]")
    end

  end

  context 'viewing articles' do

    let!(:article){Article.create(title:'Awesome Story')}

    scenario 'lets a user view an article' do
      visit '/articles'
      click_link "Awesome Story"
      expect(page).to have_content "Awesome Story"
      expect(current_path).to eq "/articles/#{article.id}"
    end

  end

  context 'editing articles' do

    let!(:article){Article.create(title:'Awesome Story')}

    scenario 'let a user edit an article' do
      visit '/articles'
      click_link 'Awesome Story'
      click_link 'Edit Story'
      fill_in 'Title', with: 'This is an awesome story'
      click_button 'Update Story'
      expect(page).to have_content 'This is an awesome story'
      expect(current_path).to eq "/articles/#{article.id}"
    end

  end

  context 'deleting articles' do

    before {Article.create title: 'Awesome Story'}

    scenario 'let a user delete an article' do
      visit '/articles'
      click_link 'Awesome Story'
      click_link 'Delete Story'
      expect(page).not_to have_content 'Awesome Story'
      expect(page).to have_content 'Story deleted successfully'
    end

  end


end
