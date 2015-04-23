class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    Article.create(article_params)
    redirect_to "/articles"
  end

  def show
    @article = Article.find(params[:id])
  end

  def article_params
  params.require(:article).permit(:title, :story, :photo)
end

end
