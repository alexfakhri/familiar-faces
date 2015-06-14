class AdminController < ApplicationController

  load_and_authorize_resource :class => AdminController

  def index
    @articles = Article.all
    @published_articles = Article.where(visibility: true)
    @unpublished_articles = Article.where(visibility: false)
  end

end
