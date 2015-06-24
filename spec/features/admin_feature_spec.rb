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
      create(:article)
    end

    before do
      @user = FactoryGirl.create(:user, :admin_user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

    scenario 'lets a user view an article' do
      visit '/admin'
      expect(page).to have_content "Panda goes to Brazil"
    end

  end

  context 'admin users editing articles' do

    before do
      create(:article)
    end

    before do
      @user = FactoryGirl.create(:user, :admin_user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
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
      create(:article)
    end

    before do
      @admin = FactoryGirl.create(:user, :admin_user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

    scenario 'lets an admin user delete an article' do
      visit '/admin'
      click_link 'Delete Story'
      expect(page).not_to have_content 'Panda goes to Brazil'
      expect(page).to have_content 'Story deleted successfully'
    end

  end

  context 'admin user publishing articles' do

    before do
      @article = create(:article, visibility: false)
    end

    before do
      @admin = FactoryGirl.create(:user, :admin_user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
      visit '/admin'
    end

    scenario 'and article should not be published when created' do
      expect(page).to have_content "Not Published"
    end

    scenario 'and article should be published on click of checkbox', js: true do
      expect(page).to have_content("Not Published")
      bip_bool @article, :visibility
      expect(page).to have_content("Published")
    end

  end

end
