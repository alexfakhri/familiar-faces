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

    scenario 'contributor user should be able to view the admin page' do
      visit "/admin"
      expect(page).to have_content "You must be an Admin user to do this"
      expect(current_path).to eq "/"
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
    end

    let!(:article){Article.create(title:'Awesome Story')}

    scenario 'lets an admin user edit an article' do
      visit '/articles'
      click_link 'Awesome Story'
      click_link 'Edit Story'
      fill_in 'Title', with: 'This is an awesome story'
      click_button 'Update Story'
      expect(page).to have_content 'This is an awesome story'
      expect(current_path).to eq "/articles/#{article.id}"
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
      visit '/articles'
      click_link 'Awesome Story'
      click_link 'Delete Story'
      expect(page).not_to have_content 'Awesome Story'
      expect(page).to have_content 'Story deleted successfully'
    end

  end

end
