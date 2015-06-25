class UsersController < ApplicationController

  load_and_authorize_resource

  def show
    @user = User.find(params[:id])
    @article = @user.articles.where(visibility: true)
  end

end
