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

    before do
      @user = FactoryGirl.create(:user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

    before(:each) do
      article = create(:article, :south_america)
      visit '/articles'
      click_link 'Panda goes to Brazil'
      # fill_in 'Tags', with: 'London, Jaipur, Tokyo'
    end

    scenario 'displays article title on show page' do
      expect(page).to have_content 'Panda goes to Brazil'
    end

    scenario 'displays article story on show page' do
      expect(page).to have_content 'A night out in Rio'
    end

    scenario 'displays article image on show page' do
      expect(page).to have_css("img[alt=Panda]")
    end

    scenario 'displays article location on show page' do
      expect(page).to have_content 'Brazil'
    end

    scenario 'displays article tags on show page' do
      expect(page).to have_content 'South America'
    end

    scenario 'displays tags on article index page' do
      visit '/articles'
      expect(page).to have_content 'South America'
    end

    scenario 'displays article tags on show page' do
      expect(page).to have_content 'London'
      expect(page).to have_content 'Jaipur'
      expect(page).to have_content 'Tokyo'
    end

    scenario 'displays tags on article index page' do
      visit '/articles'
      expect(page).to have_content 'London'
      expect(page).to have_content 'Jaipur'
      expect(page).to have_content 'Tokyo'
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

    before do
      @user = FactoryGirl.create(:user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

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

    before do
      @user = FactoryGirl.create(:user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

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
