class HomeController < ApplicationController

  def index
    @articles = Article.where(visibility: true)
  end

end
