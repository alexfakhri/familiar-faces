require 'rails_helper'

feature 'admin user' do

  context 'viweing the admin page' do

    before do
      @user = FactoryGirl.create(:user, :admin_user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

    scenario 'admin user should be able to view the admin page' do
      visit "/admin"
      expect(current_path).to eq "/admin"
    end

  end

  context 'contributor viewing the admin page' do

    before do
      @user = FactoryGirl.create(:user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

    scenario 'contributor user should not be able to view the admin page' do
      visit "/admin"
      expect(page).to have_content "You must be an Admin user to do this"
      expect(current_path).to eq "/"
    end

  end

  context 'viewing articles on the admin page' do

    before do
      @user = FactoryGirl.create(:user, :admin_user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

    before {Article.create title: 'Awesome Story'}

    scenario 'lets a user view an article' do
      visit '/admin'
      expect(page).to have_content "Awesome Story"
    end

  end

  context 'admin users editing articles' do

    before do
      @user = FactoryGirl.create(:user, :admin_user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
      visit '/articles'
      click_link 'Add a new story'
      fill_in 'Title', with: 'Awesome story'
      click_button 'Add Story'
    end

    scenario 'lets an admin user edit an article' do
      visit '/admin'
      click_link 'Edit Story'
      fill_in 'Title', with: 'This is an awesome story'
      click_button 'Update Story'
      expect(page).to have_content 'This is an awesome story'
    end

  end

  context 'admin user deleting articles' do

    before do
      @admin = FactoryGirl.create(:user, :admin_user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

    before {Article.create title: 'Awesome Story'}

    scenario 'lets an admin user delete an article' do
      visit '/admin'
      click_link 'Delete Story'
      expect(page).not_to have_content 'Awesome Story'
      expect(page).to have_content 'Story deleted successfully'
    end

  end

  context 'admin user publishing articles' do

    before do
      @admin = FactoryGirl.create(:user, :admin_user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

    before do
      @article = Article.create title: 'Awesome Story'
    end

    scenario 'and article should not be punlished when created' do
      visit '/admin'
      expect(page).to have_content "Not Published"
    end

    scenario 'and article should be punlished on click of checkbox', js: true do
      visit '/admin'
      expect(page).to have_content("Not Published")
      bip_bool @article, :visibility
      expect(page).to have_content("Published")
    end

  end

end
