class ArticlesController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
  if params[:tag]
    @articles = Article.tagged_with(params[:tag])
  else
    @articles = Article.all
  end
end

  def new
    @article = Article.new
  end

  def create
    @user = current_user
    @user.articles.create(article_params)
    redirect_to "/articles"
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    redirect_to article_path
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = 'Story deleted successfully'
    redirect_to articles_path
  end

  def article_params
  params.require(:article).permit(:title, :story, :photo, :location, :tag_list)
end

end
