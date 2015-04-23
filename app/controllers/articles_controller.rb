class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
  end

  def create
    Article.create(article_params)
    redirect_to "/articles"
  end

  def article_params
  params.require(:article).permit(:title)
end

end
