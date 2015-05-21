require 'rails_helper'

feature 'admin user' do

  context 'admin users editing articles' do

    before do
      @user = FactoryGirl.create(:user, :admin_user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
      save_and_open_page
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
