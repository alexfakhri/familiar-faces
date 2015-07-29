class ArticlesController < ApplicationController

  load_and_authorize_resource

  before_action :authenticate_user!, :except => [:index, :show]

  respond_to :html, :json

  def index
    if params[:tag]
      @articles = Article
        .where(visibility: true)
        .tagged_with(params[:tag])
    else
      @articles = Article.where(visibility: true).order('updated_at DESC')
    end
  end

  def new
    @article = Article.new
  end

  def create
    @user = current_user
    @article = @user.articles.create(article_params)
    if @article.save
      redirect_to "/articles"
    else
      render 'new'
    end
  end

  def show
    @user = current_user

    if @article.visibility == true
      @article = Article.find(params[:id])
    elsif @user == nil
      flash[:notice] = 'Article not published yet'
      redirect_to '/'
    elsif @user.role == "admin"
      @article = Article.find(params[:id])
    else
      flash[:notice] = 'Article not published yet'
      redirect_to '/'
    end

    @related_articles = Article
      .where(visibility: true, image_orientation: 'landscape').limit(4)
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
    redirect_to :back
  end

  def article_params
  params.require(:article).permit(:title, :story, :photo, :location, :tag_list, :visibility, :image_orientation)
end

end
