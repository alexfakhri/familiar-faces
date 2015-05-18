require 'rails_helper'

RSpec.describe Article, type: :model do

  before(:each) do
    article = create(:article)
  end

  it "has a title" do
    article = Article.last
    expect(article.title).to eq "Awesome Story"
  end

  it "has a story" do
    article = Article.last
    expect(article.story).to eq "This is one awesome story"
  end

end
