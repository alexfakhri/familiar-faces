class ResultsController < ApplicationController

  def index
    @articles = Article.where(visibility: true)
    render json: @articles.to_json(include: [:user])
  end

  def show
    @article = Article.find(params[:id])
    render json: @article.to_json(include: [:user])
  end

end
