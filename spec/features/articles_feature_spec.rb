require 'rails_helper'

feature 'article' do

  context 'no articles have been added' do

    scenario 'displays a prompt to add an article' do
      visit '/articles'
      expect(page).to have_content 'No articles yet'
      expect(page).to have_content 'Add a new story'
    end

  end

  context 'articles that have been added should not be approved' do

    before do
      create(:article, visibility: false)
    end

    scenario 'article should not be displaying' do
      visit '/articles'
      expect(page).not_to have_content 'Panda goes to Brazil'
      expect(page).to have_content 'No articles yet'
    end

  end

  context 'articles that have been approved' do

    before do
      create(:article)
    end

    scenario 'should be displayed' do
      visit '/articles'
      expect(page).to have_content 'Panda goes to Brazil'
      expect(page).not_to have_content 'No articles yet'
    end

  end

  context 'creating articles' do

    before do
      @user = create(:user)
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
    end

    scenario 'after approval displays article title on show page' do
      expect(page).to have_content 'Panda goes to Brazil'
    end

    scenario 'after approval displays article story on show page' do
      expect(page).to have_content 'A night out in Rio'
    end

    scenario 'after approval displays article image on show page' do
      expect(page).to have_css("img[alt=Panda]")
    end

    scenario 'after approval displays article location on show page' do
      expect(page).to have_content 'Brazil'
    end

    scenario 'after approval displays article tags on show page' do
      expect(page).to have_content 'South America'
    end

    scenario 'after approval displays tags on article index page' do
      visit '/articles'
      expect(page).to have_content 'South America'
    end

  end

  context 'viewing articles' do

    let!(:article){create(:article)}

    scenario 'after approval lets a user view an article' do
      visit '/articles'
      click_link "Panda goes to Brazil"
      expect(page).to have_content "Panda goes to Brazil"
      expect(current_path).to eq "/articles/#{article.id}"
    end

  end

  context 'selecting image orientation and rendering templates' do

    before do
      @user = create(:user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

    scenario 'when selecting portrait it should render the portrait template' do
      article = create(:article, :south_america)
      visit '/articles'
      click_link "Panda goes to Brazil"
      save_and_open_page
      expect(page).to have_css(".portrait_layout")
    end

    scenario 'when selecting portrait it should render the portrait template' do
      article = create(:article, :south_america, image_orientation: "landscape")
      visit '/articles'
      click_link "Panda goes to Brazil"
      expect(page).to have_css(".landscape_layout")
    end

  end

end
