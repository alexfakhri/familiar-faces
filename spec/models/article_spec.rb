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

  it "has a location" do
    article = Article.last
    expect(article.location).to eq "Brazil"
  end

  it "has an image" do
    article = Article.last
    expect(article.photo_file_name).to eq "panda.jpg"
  end

  it "has visibility set to false by default" do
    article = Article.last
    expect(article.visibility).to eq false
  end


end
