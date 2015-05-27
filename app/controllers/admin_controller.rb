class AdminController < ApplicationController

  load_and_authorize_resource :class => AdminController

  def index
    @articles = Article.all
  end

end
