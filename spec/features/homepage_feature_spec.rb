require 'rails_helper'

feature 'homepage' do

  context 'viewing' do

    before do
      @article = create(:article)
      visit "/"
    end

    scenario "displays a list of articles when visibility is true" do
      byebug
      expect(page).to have_content "Panda goes to Brazil"
    end
  end

end
