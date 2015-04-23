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
      visit "/"
      click_link "Sign Up"
      fill_in("Email", with: "panda@familarfaces.com")
      fill_in("Password", with: "happiness101")
      fill_in("Password confirmation", with: "happiness101")
      click_button "Sign up"
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

  end

end
