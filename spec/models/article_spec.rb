require 'rails_helper'

RSpec.describe Article, type: :model do

  before(:each) do
    article = create(:article)
  end

  it "has a title" do
    article = Article.last
    expect(article.title).to eq "Panda goes to Brazil"
  end

  it "has a story" do
    article = Article.last
    expect(article.story).to eq "A night out in Rio"
  end

end
