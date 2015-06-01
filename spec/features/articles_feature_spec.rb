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

  context 'contributors editing articles' do

    before do
      @user = create(:user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

    let!(:article){Article.create(title:'Awesome Story')}

    scenario 'does not let a contributor edit an article' do
      visit '/articles'
      click_link 'Awesome Story'
      p @user.role
      click_link 'Edit Story'
      expect(page).to have_content 'You must be an Admin user to do this'
    end

  end

  context 'contributors deleting articles' do

    before do
      @user = FactoryGirl.create(:user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

    before {Article.create title: 'Awesome Story'}

    scenario 'does not let a contirbutor delete an article' do
      visit '/articles'
      click_link 'Awesome Story'
      click_link 'Delete Story'
      expect(page).to have_content 'You must be an Admin user to do this'
    end

  end

end
