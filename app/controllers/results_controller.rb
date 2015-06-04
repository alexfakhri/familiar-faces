class ResultsController < ApplicationController

  def index
    render json: Article.where(visibility: true)
  end

  def show
    render json: Article.find(params[:id])
  end

end
