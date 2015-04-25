require 'rails_helper'

feature 'users' do

  context "user is not signed in" do

    before do
      visit "/"
    end

    scenario "displays sign in link" do
      expect(page).to have_link "Sign In"
    end

    scenario "displays sign up link" do
      expect(page). to have_link "Sign Up"
    end

    scenario "sign out link is not displayed" do
      expect(page).not_to have_link "Sign Out"
    end

  end

  context "user is signed in" do

    before do
      @user = FactoryGirl.create(:user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
    end

    scenario "sign out link is displayed" do
      expect(page).to have_link "Sign Out"
    end

    scenario "sign in link are not displayed" do
      expect(page).not_to have_link "Sign In"
    end

    scenario "sign up link are not displayed" do
      expect(page).not_to have_link "Sign Up"
    end

    scenario "a user can edit their profile" do
      visit "/"
      click_link "Edit Profile"
      fill_in("Bio", with: "I am a happy panda")
      fill_in("Current password", with: "happiness101")
      click_button "Update"
      click_link "View Profile"
      expect(page).to have_content "I am a happy panda"
    end

  end

  context "a user can view their profile" do

    before do
      @user = FactoryGirl.create(:user)
      visit "/"
      click_link "Sign In"
      fill_in("Email", with: "panda@familiarfaces.co")
      fill_in("Password", with: "happiness101")
      click_button "Log in"
      click_link "Edit Profile"
      fill_in("Bio", with: "I am a happy panda")
      fill_in("Current password", with: "happiness101")
      attach_file "user[avatar]", "#{Rails.root}/public/images/test/test.jpg"
      click_button "Update"
      click_link "View Profile"
    end

    scenario "displays the user name" do
      expect(page).to have_content("Happy Panda")
    end

    scenario "displays the bio" do
      expect(page).to have_content("I am a happy panda")
    end

    scenario "displays user avatar" do
      expect(page).to have_css("img[alt=Test]")
    end

  end

end
