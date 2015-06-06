class ArticlesController < ApplicationController

  load_and_authorize_resource

  before_action :authenticate_user!, :except => [:index, :show]

  respond_to :html, :json

  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.where(visibility: true)
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
    # @related_articles = Article.tagged_with(@article.tag_list, any: true)
    @related_articles = Article
      .joins(:taggings)
      .where('articles.id != ?', @article.id)
      .where(taggings: { tag_id: @article.tag_ids })
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    respond_with @article
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = 'Story deleted successfully'
    redirect_to articles_path
  end

  def article_params
  params.require(:article).permit(:title, :story, :photo, :location, :tag_list, :visibility, :image_orientation)
end

end
